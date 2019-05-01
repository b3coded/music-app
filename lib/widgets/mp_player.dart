import 'package:flutter/material.dart';

class MPAnimatedView extends StatefulWidget {
  final Widget _content;
  MPAnimatedView( this._content);

  @override
  _MPAnimatedViewState createState() => new _MPAnimatedViewState();
}

class _MPAnimatedViewState extends State<MPAnimatedView> with TickerProviderStateMixin{
  bool active = false;
  double initialHeightSize = 70;
  double height = 70;
  static GlobalKey _keyRed = GlobalKey();

  static double _getSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    return renderBoxRed.size.height;
  }
  @override
  Widget build(BuildContext context) {
    Widget content = widget._content;

    return AnimatedSize(
        vsync: this,
        duration: new Duration(milliseconds: 200),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            height = active ? initialHeightSize : double.infinity;
            active = !active;
            setState(() {});
          },
          child: new Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            constraints: BoxConstraints(maxHeight: height),
            key: _keyRed,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.indigo
            ),
            child: content,
          ),
        )

    );


  }
}