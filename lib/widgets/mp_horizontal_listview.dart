import 'dart:io';
import 'package:music_app/data/song_data.dart';
import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_circle_avatar.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:flutter/material.dart';

class MPArtistsView extends StatelessWidget{
  final List<MaterialColor> _colors = Colors.primaries;
  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    SongData songData = rootIW.songData;


    List<String> artists = [];
    int i = 0;
    while(i < songData.songs.length){
      var artist = songData.songs[i].artist;
      if(artists.indexOf(artist) == -1){
        artists.add(artist);
      }
      i++;
    }
    return new GridView.count(
      crossAxisCount: 2,
      children: List.generate(artists.length, (index){
        var a = artists[index];
        final MaterialColor color = _colors[index % _colors.length];
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              //TODO: Page with Artist Musics
            },
            child: Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 120,
                              decoration: new BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          a,
                          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ]
                )
            )
        );
      }),
    );
  }
}