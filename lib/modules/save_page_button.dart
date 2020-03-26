import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/saved_pages_provider.dart';
import 'package:wiki_map/providers/select_wiki_page_provider.dart';
import 'package:wiki_map/providers/theme_provider.dart';

class SavePageButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double iconSize;
  final Widget nextPage;
  final Color color;

  SavePageButton(
      {@required this.icon,
      @required this.width,
      @required this.iconSize,
      @required this.nextPage,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var savedPagesProvider = Provider.of<SavedPagesProvider>(context);
    var selectWikiPageProvider = Provider.of<SelectWikiPageProvider>(context);
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
            savedPagesProvider
                .addSavedPage(selectWikiPageProvider.articleTitle);
            savedPagesProvider.addSavedWikiPageId('1111111');
          }),
    );
  }
}
