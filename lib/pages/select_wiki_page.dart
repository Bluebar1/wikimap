import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wiki_map/modules/wiki_location_module.dart';
import 'package:wiki_map/modules/wiki_select_page_buttons.dart';
import 'package:wiki_map/providers/select_wiki_page_provider.dart';
import 'package:wiki_map/providers/theme_provider.dart';

class SelectWikiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var selectWikiPageProvider = Provider.of<SelectWikiPageProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Wiki Page'),
        ),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: selectWikiPageProvider.imageUrl,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(seconds: 1),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(themeProvider.hexOfCurrentPrimary)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  WikiSelectPageButtons(),
                  Text(
                    selectWikiPageProvider.articleTitle,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  WikiLocationModule()
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(themeProvider.hexOfCurrentPrimary)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  selectWikiPageProvider.summary,
                  maxLines: 20,
                  overflow: TextOverflow.fade,
                ),
              ),
            )
          ],
        ));
  }
}
