import 'dart:io';
import 'package:music_app/data/song_data.dart';
import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_circle_avatar.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:flutter/material.dart';

class Recomendations extends StatelessWidget {
  final List<MaterialColor> _colors = Colors.primaries;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final rootIW = MPInheritedWidget.of(context);
    SongData songData = rootIW.songData;

    //
    return new Container(
      constraints: BoxConstraints( maxHeight: 120),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: songData.songs.map((data)=>
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // TODO:
              },
              child: new Container(
                height: 120,
                width: 120,
                constraints: BoxConstraints( maxHeight: 120),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.pinkAccent
                ),
                child: new Text(data.title, style: TextStyle(color: Colors.white),),
              ),
            )
        ).toList(),
      ),
    );
  }
}
