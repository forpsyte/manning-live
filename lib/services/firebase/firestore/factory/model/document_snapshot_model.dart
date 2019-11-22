import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class DocumentSnapshotModel extends AbstractObject {
  DocumentSnapshotModel({Map<String, dynamic> data}) : super(data: data);
  
  DocumentSnapshotModel.fromDocumentSnapshot(DocumentSnapshot document) {
    final List<String> keys = document.data.keys.toList();
    keys.forEach((key){
      setData(key, document[key]);
    });
    setData('document_id', document.documentID);
    setData('snapshot', document);
  }

  bool get snapshot => getData('snapshot');
  bool get exists => getData('snapshot').exists;
}