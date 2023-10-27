import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/support_model.dart';

class SupportsFunction {
  List<SupportModel> getSupportDocs(
      List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<SupportModel> supports = [];
    docs.map((doc) async {
      DocumentSnapshot<Map<String, dynamic>> docSnap = doc;
      supports.add(SupportModel().fromSnap(docSnap.data()!));
    }).toList();
    return supports;
  }
}