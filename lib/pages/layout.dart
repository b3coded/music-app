import 'package:flutter/material.dart';
import 'package:music_app/pages/artists_page.dart';
import 'package:music_app/pages/root_page.dart';
import 'package:music_app/pages/home.dart';
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
    HomePage(),
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
              _widgetOptions.elementAt(_selectedIndex)
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