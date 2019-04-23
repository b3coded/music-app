import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:music_app/widgets/mp_lisview.dart';
import 'package:music_app/widgets/mp_horizontal_listview.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

//TODO: add state para paginas
class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final rootIW = MPInheritedWidget.of(context);
    //Goto Now Playing Page
    void goToNowPlaying(Song s, {bool nowPlayTap: false}) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new NowPlaying(
                rootIW.songData,
                s,
                nowPlayTap: nowPlayTap,
              )));
    }

    //Shuffle Songs and goto now playing page
    void shuffleSongs() {
      goToNowPlaying(rootIW.songData.randomSong);
    }

    final body = rootIW.isLoading
        ? new Center(child: new CircularProgressIndicator())
        :  Container(
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
                  new Text("Musics", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  SizedBox(height: 16),

                  new Expanded(child: MPListView())
                ],
              ),
            )
          ]
      ),
    );


    return body;
  }
}
