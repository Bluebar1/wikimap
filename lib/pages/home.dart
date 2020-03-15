import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/settings.dart';




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Testing'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
            },
          ),

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Text('Map Testing'),
            ),
            Container(
              child: Text('Map Testing'),
            ),
          ],
        ),
      ),
    );
  }
}
