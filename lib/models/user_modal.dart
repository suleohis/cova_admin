import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constants.dart';


class UserModel {
  String? uid;
  String? username;
  String? email;
  DateTime? createdAt;
  DateTime? signInAt;
  // String? imageUrl;

  String? role;

  UserModel(
      { this.uid,
         this.username,
       this.email,
       this.createdAt,
       this.signInAt,
       // this.imageUrl,
        this.role
      });

  UserModel.fromSnapshot(DocumentSnapshot<dynamic> snapshot) {
    uid = snapshot.data()[AppConstants.uid] ?? '';
    username = snapshot.data()[AppConstants.username] ?? '';
    email = snapshot.data()[AppConstants.email] ?? '';
    createdAt =  DateTime.parse(snapshot.data()[AppConstants.createdAt].toDate().toString());
    signInAt = DateTime.parse(snapshot.data()[AppConstants.signInAt].toDate().toString());
    // imageUrl = snapshot.data()[AppConstants.imageUrl] ?? '';
    role = snapshot.data()[AppConstants.role] ?? [];
  }

  List<UserModel> getUsers(List snapshot) {
    List<UserModel> users = [];
    for (var element in snapshot) {
      UserModel user = UserModel(
        uid: element[AppConstants.fields][AppConstants.uid][AppConstants.stringValue] ?? '',
        username: element[AppConstants.fields][AppConstants.username][AppConstants.stringValue] ?? '',
        email: element[AppConstants.fields][AppConstants.email][AppConstants.stringValue],
        createdAt: DateTime.parse(element[AppConstants.fields][AppConstants.createdAt][AppConstants.timestampValue]),
        signInAt: DateTime.parse(element[AppConstants.fields][AppConstants.signInAt][AppConstants.timestampValue]),
        // // imageUrl: element[AppConstants.imageUrl],
        role: element[AppConstants.fields][AppConstants.role][AppConstants.stringValue],
      );
      users.add(user);
    }
    return users;
  }

  UserModel getUser(Map<String, dynamic> snapshot) {
    UserModel user = UserModel(
        uid: snapshot[AppConstants.uid] ?? '',
        username: snapshot[AppConstants.username],
        email: snapshot[AppConstants.email],
        createdAt: DateTime.parse(snapshot[AppConstants.createdAt].toDate().toString()),
        signInAt: DateTime.parse(snapshot[AppConstants.signInAt].toDate().toString()),
        // imageUrl: snapshot[AppConstants.imageUrl],
      role: snapshot[AppConstants.role],
    );
    return user;
  }
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map[AppConstants.uid] ?? '',
        username: map[AppConstants.username] ?? '',
        email: map[AppConstants.email],
        createdAt: DateTime.parse(map[AppConstants.createdAt].toDate().toString()),
        signInAt: DateTime.parse(map[AppConstants.signInAt].toDate().toString()),
        // imageUrl: map[AppConstants.imageUrl],
      role: map[AppConstants.role],
    );
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      AppConstants.uid: uid,
      AppConstants.username: username,
      AppConstants.email: email,
      AppConstants.createdAt: Timestamp.fromDate(createdAt!),
      AppConstants.signInAt: Timestamp.fromDate(signInAt!),
      // AppConstants.imageUrl: imageUrl,
      AppConstants.role: role
    };
    return map;
  }

}
