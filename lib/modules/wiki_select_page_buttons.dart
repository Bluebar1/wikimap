import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/modules/save_page_button.dart';
import 'package:wiki_map/modules/view_wiki_page_button.dart';
import 'package:wiki_map/providers/theme_provider.dart';

class WikiSelectPageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ViewWikiPageButton(
            color: Color(themeProvider.hexOfCurrentPrimary),
            iconSize: 30,
            icon: Icons.accessibility_new,
            nextPage: Text('yo'),
            width: 60,
          ),
          ViewWikiPageButton(
            color: Colors.red,
            iconSize: 30,
            icon: Icons.accessibility_new,
            nextPage: Text('yo'),
            width: 60,
          ),
          SavePageButton(
            color: Colors.red,
            iconSize: 30,
            icon: Icons.add,
            nextPage: Text('yo'),
            width: 60,
          ),
        ],
      ),
    );
  }
}
