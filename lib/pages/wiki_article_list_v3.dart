import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wiki_map/pages/select_wiki_page.dart';
import 'package:wiki_map/providers/select_wiki_page_provider.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';

class WikiArticleListV3 extends StatelessWidget {
  void _viewWikiPage(
      BuildContext context, WikiArticleProvider provider, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
            value: SelectWikiPageProvider(provider, index),
            child: Consumer<SelectWikiPageProvider>(
              builder: (BuildContext context, SelectWikiPageProvider provider,
                  Widget child) {
                return SelectWikiPage();
              },
            ))));
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
            onTap: () => _viewWikiPage(context, wikiArticleProvider, index),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            wikiArticleProvider.articleTitleList[index],
                            style: Theme.of(context).textTheme.title,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              wikiArticleProvider.summaryList[index],
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16.0),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  '${(wikiArticleProvider.distanceList[index] * 0.00062137119224).toStringAsPrecision(3)}',
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(' miles Away',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
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
