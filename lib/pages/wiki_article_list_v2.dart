import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wiki_map/modules/animated_summary.dart';
import 'package:wiki_map/modules/view_wiki_page_button.dart';
import 'package:wiki_map/modules/wiki_location_module.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/map_provider.dart';
import 'package:wiki_map/providers/wiki_article_list_provider.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';

class WikiArticleListV2 extends StatelessWidget {
  void _viewWikiPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Settings()));
  }

  @override
  Widget build(BuildContext context) {
    var wikiArticleProvider = Provider.of<WikiArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Wiki Article List')),
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: wikiArticleProvider.summaryList.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _viewWikiPage(context),
            child: FutureBuilder(builder: (context, snapshot) {
              return GridTile(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 408,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: wikiArticleProvider.imageUrlList[index],
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(seconds: 1),
                      ),
                    ),
                    Container(
                      height: 408,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(0, 0, 0, .4)),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              wikiArticleProvider.articleTitleList[index],
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.map,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              Icon(
                                Icons.library_books,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.deepOrange,
                                size: 30.0,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              wikiArticleProvider.summaryList[index],
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
