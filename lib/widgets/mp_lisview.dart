import 'dart:io';
import 'package:music_app/data/song_data.dart';
import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_circle_avatar.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:flutter/material.dart';

class MPListView extends StatelessWidget {
  final List<MaterialColor> _colors = Colors.primaries;

  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    SongData songData = rootIW.songData;

    return new ListView.builder(
        itemCount: songData.songs.length,
        itemBuilder: (context, int index){
          var s = songData.songs[index];
          final MaterialColor color = _colors[index % _colors.length];
          var artFile =
          s.albumArt == null ? null : new File.fromUri(Uri.parse(s.albumArt));

          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                songData.setCurrentIndex(index);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new NowPlaying(songData, s)));
              },
              child: new Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
                          height: 50.0,
                          width: 50.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: artFile != null
                                  ? new Image.file(
                                artFile,
                                fit: BoxFit.cover,
                              )
                                  : new CircleAvatar(
                                child: new Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                backgroundColor: color,
                              )
                          ),
                        ),
                        Container(
                            constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
                            height: 50.0,
                            width: 50.0,
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white.withOpacity(0.4),
                              size: 32.0,
                            ))
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            s.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            s.artist,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5), fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white.withOpacity(0.6),
                        size: 32.0,
                      ),
                    )

                  ],
                ),
              )
          );

        }
    );



  }
}
