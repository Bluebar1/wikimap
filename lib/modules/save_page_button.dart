import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/map_provider.dart';
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

  _showPageSavedFlushBar(BuildContext context, String message) {
    return Flushbar(
      message: message,
      duration: Duration(seconds: 2),
      isDismissible: true,
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Colors.black,
      borderRadius: 8,
      margin: EdgeInsets.all(5),
      borderColor: Colors.white,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: Icon(Icons.error, color: Colors.amber),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var savedPagesProvider = Provider.of<SavedPagesProvider>(context);
    var selectWikiPageProvider = Provider.of<SelectWikiPageProvider>(context);
    //var mapProvider = Provider.of<MapProvider>(context);

    _addSavedPage(BuildContext context) {
      // String _tempPageId =
      //     mapProvider.getPageIdByTitle(selectWikiPageProvider.articleTitle);
      //print(mapProvider.pageIdList.toString());
      savedPagesProvider.addSavedPage(selectWikiPageProvider.articleTitle);
      savedPagesProvider
          .addSavedWikiPageId(selectWikiPageProvider.pageId.toString());
      _showPageSavedFlushBar(
          context,
          'Page: "' +
              '${selectWikiPageProvider.articleTitle}' +
              '" Has Been Saved! | ' +
              '${selectWikiPageProvider.pageId}');
    }

    return Container(
      width: width,
      child: IconButton(
          color: Color(themeProvider.hexOfCurrentBackground),
          icon: Icon(
            icon,
            color: color,
            size: iconSize,
          ),
          onPressed: () {
            _addSavedPage(context);
          }),
    );
  }
}
