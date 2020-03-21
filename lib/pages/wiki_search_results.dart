import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/modules/animated_summary.dart';
import 'package:wiki_map/modules/wiki_location_module.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';




class WikiSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wikiArticleProvider = Provider.of<WikiArticleProvider>(context);
    return DraggableScrollableSheet(
      initialChildSize: .8,
      maxChildSize: .9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(20, 20, 20, 1),
          ),
          child: ListView.builder(
            //physics: new NeverScrollableScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.all(5),
              itemCount: wikiArticleProvider.summaryList.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 80,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Container(
                        // A fixed-height child.
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(wikiArticleProvider.imageUrlList[index]),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, .55), BlendMode.darken)
                            )
                        ),
                        //height: 165.0,
                        child: Center(
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: WikiLocationModule(index)),
                              //SizedBox(height: 100),

                              Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: AnimatedSummary(wikiArticleProvider.summaryList[index])),
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        );
      },
    );
  }
}




