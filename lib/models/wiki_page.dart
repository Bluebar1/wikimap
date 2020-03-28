import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WikiPage extends Equatable {
  final String title;
  final String id;

  WikiPage({@required this.title, @required this.id});

  static WikiPage fromMap(Map<String, dynamic> json) {
    return WikiPage(title: json['title'], id: json['id']);
  }

  @override
  List<Object> get props => [
        title,
        id,
      ];

  /*
  static List<WikiPage> listFromMap(Map<String, dynamic> json, String key) {
    List<WikiPage> response = List<WikiPage>();
    String jsonKey;

    if (key == 'title') {
      jsonKey = 'titles';
    } else if (key == 'id') {
      jsonKey = 'ids';
    }


  }
  */
}
