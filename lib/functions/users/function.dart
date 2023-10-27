import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_modal.dart';

class UsersFunction {
  List<UserModel> getUserDocs(
      List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    List<UserModel> users = [];
    docs.map((doc) async {
      DocumentSnapshot<Map<String, dynamic>> docSnap = doc;
      users.add(UserModel.fromMap(docSnap.data()!));
    }).toList();
    return users;
  }
}