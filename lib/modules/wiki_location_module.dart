import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';


class WikiLocationModule extends StatelessWidget {
  int _index;

  WikiLocationModule(int index) {
    this._index = index;
  }

  @override
  Widget build(BuildContext context) {
    var wikiArticleProvider = Provider.of<WikiArticleProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
                color: Color.fromRGBO(20, 100, 20, 0),
                border: Border(
                    right: BorderSide(width: 1, color: Color(0xFFFFFFFFFF)),
                    left: BorderSide(width: 1, color: Color(0xFFFFFFFFFF))
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    'Location Data',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight:  FontWeight.w600,
                        fontSize: 14,
                        color: Color.fromRGBO(192, 192, 192, 1.0)
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '${(wikiArticleProvider.distanceList[_index]*0.00062137119224).toStringAsPrecision(3)}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight:  FontWeight.w600,
                            fontSize: 12,
                            color: Color.fromRGBO(192, 192, 192, 0.8)
                        )
                    ),
                    Text(
                        ' miles Away',
                        style: Theme.of(context).textTheme.subhead
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Longitude: ',
                        style: Theme.of(context).textTheme.subhead
                    ),
                    Text(
                        '${(wikiArticleProvider.latitudeList[_index]).toStringAsPrecision(9)}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight:  FontWeight.w600,
                            fontSize: 12,
                            color: Color.fromRGBO(192, 192, 192, 0.8)
                        )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Longitude: ',
                        style: Theme.of(context).textTheme.subhead
                    ),
                    Text(
                        '${(wikiArticleProvider.longitudeList[_index]).toStringAsPrecision(9)}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight:  FontWeight.w600,
                            fontSize: 12,
                            color: Color.fromRGBO(192, 192, 192, 0.8)
                        )
                    ),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}