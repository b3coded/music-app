import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:music_app/widgets/mp_lisview.dart';
import 'package:music_app/widgets/mp_horizontal_listview.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

//TODO: add state para paginas
class ArtistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final rootIW = MPInheritedWidget.of(context);
    //Goto Now Playing Page

    final body = new Container(
      child: new Stack(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: 16),
                  new Text("Artists", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  SizedBox(height: 16),

                  new Expanded(child: MPArtistsView())
                ],
              ),
            )
          ]
      ),
    );

    return new Container(
      child: Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
          ),
          body
        ],
      ),
    );
  }
}
