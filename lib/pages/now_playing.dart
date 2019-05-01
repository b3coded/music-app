import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:music_app/data/song_data.dart';
import 'package:music_app/widgets/mp_album_ui.dart';
import 'package:music_app/widgets/mp_blur_filter.dart';
import 'package:music_app/widgets/mp_blur_widget.dart';
import 'package:music_app/widgets/mp_control_button.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:media_notification/media_notification.dart';


enum PlayerState { stopped, playing, paused }

var blueColor = Color(0xFF090e42);
var pinkColor = Color(0xFFff6b80);
var martinGarrix =
    'https://c1.staticflickr.com/2/1841/44200429922_d0cbbf22ba_b.jpg';

class NowPlaying extends StatefulWidget {
  final Song _song;
  final SongData songData;
  final bool nowPlayTap;
  NowPlaying(this.songData, this._song, {this.nowPlayTap});

  @override
  _NowPlayingState createState() => new _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  MusicFinder audioPlayer;
  Duration duration;
  Duration position;
  PlayerState playerState;
  Song song;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  @override
  initState() {
    super.initState();
    initPlayer();

    MediaNotification.setListener('pause', () {
      isPlaying ? pause() : play(song);
    });

    MediaNotification.setListener('play', () {
      isPlaying ? pause() : play(song);
    });

    MediaNotification.setListener('next', () {
      next(widget.songData);
    });

    MediaNotification.setListener('prev', () {
      prev(widget.songData);
    });

    MediaNotification.setListener('select', () {

    });
  }

  Future<void> hide() async {
    try {
      await MediaNotification.hide();
    } on PlatformException {

    }
  }

  Future<void> show(title, author) async {
    try {
      await MediaNotification.show(title: title, author: author);
    } on PlatformException {

    }
  }

  @override
  void dispose() {
    hide();
    super.dispose();
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    play(widget.songData.nextSong);
  }

  initPlayer() async {
    if (audioPlayer == null) {
      audioPlayer = widget.songData.audioPlayer;
    }
    setState(() {
      song = widget._song;
      if (widget.nowPlayTap == null || widget.nowPlayTap == false) {
        if (playerState != PlayerState.stopped) {
          stop();
        }
      }
      play(song);
      //  else {
      //   widget._song;
      //   playerState = PlayerState.playing;
      // }
    });
    audioPlayer.setDurationHandler((d) => setState(() {
      duration = d;
    }));

    audioPlayer.setPositionHandler((p) => setState(() {
      position = p;
    }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play(Song s) async {
    if (s != null) {
      final result = await audioPlayer.play(s.uri, isLocal: true);
      if (result == 1) {
        setState(() {
          playerState = PlayerState.playing;
          song = s;
        });
        show(song.title, song.artist);
      }
    }
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        position = new Duration();
      });
  }

  Future next(SongData s) async {
    stop();
    setState(() {
      play(s.nextSong);
    });
  }

  Future prev(SongData s) async {
    stop();
    play(s.prevSong);
  }

  Future mute(bool muted) async {
    final result = await audioPlayer.mute(muted);
    if (result == 1)
      setState(() {
        isMuted = muted;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueColor,
        body: SafeArea(
          top: false,
          bottom: false,
          right: false,
          left: false,
          child: Column(
            children: <Widget>[
              Container(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                song.albumArt != null ? new FileImage(File.fromUri(Uri.parse(song.albumArt))) : NetworkImage(martinGarrix),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [blueColor.withOpacity(0.3), blueColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 42.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "PLAYLIST",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                    Text("Best Vibes",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                                Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Spacer(),
                            new Text(
                              song.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                            new Text(
                              song.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Spacer(),
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:  duration == null
                ? new Container()
                : new Slider(
                activeColor: pinkColor,
                inactiveColor: pinkColor.withOpacity(0.3),
                value: position?.inMilliseconds?.toDouble() ?? 0,
                onChanged: (double value) =>
                    audioPlayer.seek((value / 1000).roundToDouble()),
                min: 0.0,
                max: duration.inMilliseconds.toDouble()),
          ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: position != null
                      ? [
                    Text(positionText,
                        style: new TextStyle(fontSize: 18.0)),
                    Text(durationText,
                        style: new TextStyle(fontSize: 18.0)),
                  ]
                      : [
                    Text(positionText,
                        style: new TextStyle(fontSize: 18.0)),
                    Text(durationText,
                        style: new TextStyle(fontSize: 18.0))
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    shape: new CircleBorder(),
                    onPressed: () {
                      prev(widget.songData);
                    },
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 38.0,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    shape: new CircleBorder(),
                    fillColor: pinkColor,
                    onPressed: () {
                      isPlaying ? pause() : play(song);
                    },
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 48.0,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    shape: new CircleBorder(),
                    onPressed: () {
                      next(widget.songData);
                    },
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 38.0,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.bookmark_border,
                    color: pinkColor,
                  ),
                  Icon(
                    Icons.shuffle,
                    color: pinkColor,
                  ),
                  Icon(
                    Icons.repeat,
                    color: pinkColor,
                  ),
                ],
              ),
              Spacer()
            ],
          ),
        )
    );
  }
}
