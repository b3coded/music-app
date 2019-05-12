import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/widgets/mp_inherited.dart';
import 'package:music_app/widgets/mp_lisview.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget{
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

    final test = Stack(
        children: <Widget>[
          Container(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    new Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                      decoration: BoxDecoration(
                          color: blueColor
                      ),
                      child: new Text("Musics", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                    ),
                    new Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: MPListView(),
                        )
                    ),

                    SizedBox(height: 76)
                  ]
              )
          ),

        ]);
    final body = rootIW.isLoading
        ? new Center(child: new CircularProgressIndicator())
        :  test;


    return body;
  }
}
