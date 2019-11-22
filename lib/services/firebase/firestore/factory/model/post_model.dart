import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/document_snapshot_model.dart';

class PostModel extends DocumentSnapshotModel {
  final HtmlUnescape _unescape = new HtmlUnescape();

  PostModel({Map<String, dynamic> data}) : super(data: data);

  PostModel.fromDocumentSnapshot(DocumentSnapshot document) {
    final List<String> keys = document.data.keys.toList();
    keys.forEach((key) {
      setData(key, document[key]);
    });
    setData('document_id', document.documentID);
    setData('snapshot', document);
  }
  
  PostModel.fromAlgoliaQuerySnapshot(Map<String, dynamic> query) {
    final List<String> keys = query.keys.toList();
    keys.forEach((key) {
      setData(key, query[key]);
    });
    setData('document_id', query['objectID']);
    setData(
        'published_at',
        new DateTime.fromMicrosecondsSinceEpoch(
            query['published_at']['_seconds'] * 1000000));
  }

  String get title => _unescape.convert(getData('title'));

  String get content => _unescape.convert(getData('content'));

  DateTime get published => new DateTime.fromMicrosecondsSinceEpoch(
      getData('published_at').microsecondsSinceEpoch);

  String getImage(String image) {
    var images = getData('images');
    return images[image];
  }

  List<String> getContent() {
    var sections = content.split("\n");
    sections.removeWhere((text) => text == "" || text == "\n");
    return sections;
  }
}
