import 'package:flutter/material.dart';
import 'package:music_app/pages/artists_page.dart';
import 'package:music_app/pages/root_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/pages/now_playing.dart';
import 'package:music_app/data/song_data.dart';
import 'package:music_app/widgets/mp_inherited.dart';

var blueColor = Color(0xFF090e42);

class Layout extends StatefulWidget{
  Layout({Key key}) : super(key: key);
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout>{
  int _selectedIndex = 0;
  final _widgetOptions = [
    RootPage(),
    ArtistsPage(),
    ArtistsPage()
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rootIW = MPInheritedWidget.of(context);
    SongData songData = rootIW.songData;

    return new Scaffold(
        backgroundColor: blueColor.withOpacity(1),

        body: SafeArea(
          top: true,
          child:  Stack(
            children: <Widget>[
              _widgetOptions.elementAt(_selectedIndex),
              Container(
                  alignment: Alignment.bottomLeft,
                  child:
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        songData.setCurrentIndex(0);
                        var s = songData.songs[0];
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) => new NowPlaying(songData, s))
                        );
                      },
                      child: new Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(maxHeight: 70),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: pinkColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Container(
                              child: Row(
                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(8),
                                    child: new CircleAvatar(
                                      child: new Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Title", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                                              Text("Artist", style: TextStyle(color: Colors.white, fontSize: 16))
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      child: new CircleAvatar(
                                        child: new Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      )
                                  )
                                ],
                              )
                          )
                      )
                  )

              )
            ],
          ),
        ),

        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: blueColor,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white,
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.grey))), // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            items: [
              new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
              new BottomNavigationBarItem(icon: Icon(Icons.queue_music), title: Text("Playlists")),
              new BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.white,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.shifting,
          ),
        )
    );

  }
}