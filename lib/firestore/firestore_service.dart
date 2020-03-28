// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:wiki_map/models/wiki_page.dart';

// final Firestore db = Firestore.instance;

// CollectionReference wikiPageCollection = db.collection('wikiPages');

// Future<bool> createWikiPage(WikiPage wikiPageModel) async {
//   try {
//     await db
//         .collection("wikiPages")
//         .document(wikiPageModel.id)
//         .setData({'title': wikiPageModel.title, 'id': wikiPageModel.id});
//     return true;
//   } on Error {
//     return false;
//   }
// }
