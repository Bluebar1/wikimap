import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/providers/saved_pages_provider.dart';
/*
Created NB 3/25/2020

Page that displays the list of saved wikipedia pages.
It's state is provided by SavedPagesProvider (saved_pages_provider.dart)
Pages are added from WikiSelectPage (wiki_select_page.dart)

Scaffold with an appbar
scrollable list widget with builder method, probably use GridView again
look at wiki_article_list.dart for dynamic gridview building

each saved page will be a short/wide gridtile 
GestureDetector onTap go to SelectWikiPage
*/

class SavedPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var savedPagesProvider = Provider.of<SavedPagesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Saved Pages')),
      body: ListView.builder(
          //physics: new NeverScrollableScrollPhysics(),
          //controller: scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: savedPagesProvider.savedPageTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => print(
                  'tap called on ${savedPagesProvider.savedPageTitles[index]}'),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(20, 100, 20, 0),
                      border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFFFFFFFFF)),
                      )),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(savedPagesProvider.savedPageTitles[index]),
                  )),
            );
          }),
    );
  }
}
//suoke
