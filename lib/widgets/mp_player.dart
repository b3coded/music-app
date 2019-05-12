import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:music_app/data/song_data.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:media_notification/media_notification.dart';
import 'package:music_app/widgets/mp_inherited.dart';

enum PlayerState { stopped, playing, paused }

var blueColor = Color(0xFF090e42);
var pinkColor = Color(0xFFff6b80);

class MPAnimatedView extends StatefulWidget {
  // final Song _song;
  // final SongData songData;
  // final bool nowPlayTap;
  // MPAnimatedView(this.songData, this._song, {this.nowPlayTap});
  MPAnimatedView();

  @override
  _MPAnimatedViewState createState() => new _MPAnimatedViewState();
}

class _MPAnimatedViewState extends State<MPAnimatedView> with TickerProviderStateMixin{
  bool active = false;

  Color bg = pinkColor;
  Duration duration;
  Duration position;




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    // SongData songData = rootIW.songData;


    return  Container(
          decoration: BoxDecoration(
            color: blueColor,
          ),
          child: Column(
            children: <Widget>[
              Container(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/bg.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
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
                              height: 22.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child:  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "PLAYLIST",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text("Best Vibes",
                                        style: TextStyle(color: Colors.white)
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                  size: 32,
                                )
                              ],
                            ),
                            Spacer(),
                            new Text(
                              "Music",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0),
                            ),
                            new Text(
                              "Artist",
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
                  )
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:  duration == null
                    ? new Container()
                    : new Slider(
                    activeColor: pinkColor,
                    inactiveColor: pinkColor.withOpacity(0.3),
                    value: position?.inMilliseconds?.toDouble() ?? 0,
                    min: 0.0,
                    max: duration.inMilliseconds.toDouble()),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: position != null
                      ? [
                    Text("00:00",
                        style: new TextStyle(fontSize: 18.0)),
                    Text("00:00",
                        style: new TextStyle(fontSize: 18.0)),
                  ]
                      : [
                    Text("00:00",
                        style: new TextStyle(fontSize: 18.0)),
                    Text("00:00",
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
                    onPressed: () {},
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
                    onPressed: () {},
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 48.0,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    shape: new CircleBorder(),
                    onPressed: () {},
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
          )
      );
  }
}