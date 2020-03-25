import 'package:flutter/material.dart';
import 'package:wiki_map/pages/settings.dart';

class ViewWikiPageButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double iconSize;
  final Widget nextPage;
  final Color color;

  ViewWikiPageButton(
      {@required this.icon,
      @required this.width,
      @required this.iconSize,
      @required this.nextPage,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
          color: Color.fromRGBO(20, 20, 20, 1),
          child: Icon(
            icon,
            color: color,
            size: iconSize,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Settings()));
          }),
    );
  }
}
