import 'package:flutter/material.dart';
import 'package:music_app/pages/artists_page.dart';
import 'package:music_app/pages/root_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
    ArtistsPage()
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: blueColor,
        body: SafeArea(
          top: true,
          child:  _widgetOptions.elementAt(_selectedIndex),
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
              new BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.headset), title: Text("Artists")),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.white,
            onTap: _onItemTapped,
          ),
        )
    );

  }
}