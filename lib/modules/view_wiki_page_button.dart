import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/theme_provider.dart';

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
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: width,
      child: RaisedButton(
          color: Color(themeProvider.hexOfCurrentBackground),
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
