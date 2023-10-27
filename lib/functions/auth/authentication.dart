import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cova_admin_dashboard/models/support_model.dart';
import 'package:cova_admin_dashboard/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/user_modal.dart';
import '../../models/cart_model.dart';
import '../snackbar.dart';

class Authentication {
  // Future<bool> signUp(
  //     {required UserModel userModal,
  //     required String password,
  //     required BuildContext context,
  //     required File? imageFile}) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: userModal.email!, password: password);
  //     if (userCredential.user != null) {
  //       userModal.uid = userCredential.user!.uid;
  //       if (imageFile != null) {
  //         return await uploadImageToFirebase(imageFile, userModal.uid!)
  //             .then((value) async {
  //           userModal.imageUrl = value;
  //           bool check = await FirebaseFirestore.instance
  //               .collection(AppConstants.usersCollection)
  //               .doc(userModal.uid)
  //               .set(userModal.toMap())
  //               .then((value) async {
  //             UserModel? user = await getCurrentUserData();
  //             if (user != null) {
  //               SaveDraft.isNameSave(user.firstName! + user.lastName!);
  //             }
  //             DocumentSnapshot mainCoach = await FirebaseFirestore.instance
  //                 .collection(AppConstants.mainCoach)
  //                 .doc(AppConstants.mainCoach)
  //                 .get();
  //
  //             List users =  [
  //               user!.uid,
  //               mainCoach[AppConstants.uid]
  //             ];
  //             List names =  [
  //               '${user.firstName!} ${user.lastName!}',
  //               mainCoach[AppConstants.name]
  //             ];
  //
  //             FirebaseFirestore.instance.collection(AppConstants.chatCollection).doc(user.uid).set({
  //               AppConstants.usersCollection: users,
  //               AppConstants.userNames: names
  //             });
  //             return true;
  //           }).catchError((e) => false);
  //           return check;
  //         });
  //       } else {
  //         bool check = await FirebaseFirestore.instance
  //             .collection(AppConstants.usersCollection)
  //             .doc(userModal.uid)
  //             .set(userModal.toMap())
  //             .then((value) async {
  //           UserModel? user = await getCurrentUserData();
  //           if (user != null) {
  //             SaveDraft.isNameSave(user.firstName! + user.lastName!);
  //           }
  //           DocumentSnapshot mainCoach = await FirebaseFirestore.instance
  //               .collection(AppConstants.mainCoach)
  //               .doc(AppConstants.mainCoach)
  //               .get();
  //
  //           List users =  [
  //             user!.uid,
  //             mainCoach[AppConstants.uid]
  //           ];
  //           List names =  [
  //             '${user.firstName!} ${user.lastName!}',
  //             mainCoach[AppConstants.name]
  //           ];
  //
  //           FirebaseFirestore.instance.collection(AppConstants.chatCollection).doc(user.uid).set({
  //             AppConstants.usersCollection: users,
  //             AppConstants.userNames: names
  //           });
  //           return true;
  //         }).catchError((e) => false);
  //         return check;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     snackBar(context, e.toString());
  //     return false;
  //   }
  // }

  // Future<bool> updateUserData(
  //     {required UserModel userModal,
  //     required BuildContext context,
  //     required File? imageFile}) async {
  //   try {
  //     if (imageFile != null) {
  //       return await uploadImageToFirebase(imageFile, userModal.uid!)
  //           .then((value) async {
  //         userModal.imageUrl = value;
  //         bool check = await FirebaseFirestore.instance
  //             .collection(AppConstants.usersCollection)
  //             .doc(userModal.uid)
  //             .set(userModal.toMap())
  //             .then((value) async {
  //           UserModel? user = await getCurrentUserData();
  //           if (user != null) {
  //             SaveDraft.isNameSave(user.firstName! + user.lastName!);
  //           }
  //           return true;
  //         }).catchError((e) => false);
  //         return check;
  //       });
  //     } else {
  //       bool check = await FirebaseFirestore.instance
  //           .collection(AppConstants.usersCollection)
  //           .doc(userModal.uid)
  //           .set(userModal.toMap())
  //           .then((value) async {
  //         UserModel? user = await getCurrentUserData();
  //         if (user != null) {
  //           SaveDraft.isNameSave(user.firstName! + user.lastName!);
  //         }
  //         return true;
  //       }).catchError((e) => false);
  //       return check;
  //     }
  //   } catch (e) {
  //     snackBar(context, e.toString());
  //     return false;
  //   }
  // }

  Future<String> uploadImageToFirebase(File imageFile, String uid) async {
    /// update image and text on firebase Storage
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(uid)
        .child('profile')
        .child('$uid.jpg');


    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imageFile.path});

    return storageRef
        .putFile(File(imageFile.path), metadata)
        .then((p0) async => await p0.ref.getDownloadURL());

    /// upload the image file to firebase storage
    /// upload the image file to firebase storage
    // String downloadUrl = await storageRef.getDownloadURL();
    // print(downloadUrl.toString());
    // return 'downloadUrl.toString()';
  }

  Future<bool> signIn(String email, String password, BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password).catchError((e) {
      snackBarDialog(context: context, title: 'Failed', message: e.toString(), isSuccess: false);
    });

    UserModel? userModel = await getCurrentUserData();
    if (userModel!.role == AppConstants.admin) {
      return userCredential.user != null ? true : false;
    } else {
      snackBarDialog(context: context, title: 'Login Failed', message: 'This Account Don\'t Exist', isSuccess: false);
      return false;
    }
  }

  Future<UserModel?> userData(String uid) async {
    var userData = await FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<DocumentSnapshot<dynamic>> getCurrentUserData2() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Get.offNamed(RouteHelper.getSignInRoute());
    }
    return FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get().then((user) async {
          // UserModel userModel = UserModel.fromMap(user.data()!);
      // DocumentSnapshot docSnap = await FirebaseFirestore.instance
      //     .collection(AppConstants.chatCollection)
      //     .doc(userModel.uid)
      //     .get();
      // if (!docSnap.exists  && userModel.role != AppConstants.coach && userModel.role != AppConstants.master) {
      //   DocumentSnapshot mainCoach = await FirebaseFirestore.instance
      //       .collection(AppConstants.mainCoach)
      //       .doc(AppConstants.mainCoach)
      //       .get();
      //
      //   List users =  [
      //     userModel.uid,
      //     mainCoach[AppConstants.uid]
      //   ];
      //   List names =  [
      //     '${userModel.firstName} ${userModel.lastName}',
      //     mainCoach[AppConstants.name]
      //   ];
      //
      //   FirebaseFirestore.instance.collection(AppConstants.chatCollection).doc(userModel.uid).set({
      //     AppConstants.usersCollection: users,
      //     AppConstants.userNames: names
      //   });
      // }
      return user;
    });
  }

  Future<List<UserModel>> getAllUsers({required String service}) async{

    http.Response response = await http.get(Uri.parse('${AppConstants.projectURI}$service${AppConstants.userURI}'));
    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);

      return UserModel().getUsers(map[AppConstants.documents]);
      // return users;
    } else {
      return [];
    }
  }

  Future<UserModelCart?> getUserCart(String uid, {required String service}) async{
    http.Response response = await http.get(Uri.parse('${AppConstants.projectURI}$service${AppConstants.userURI}/$uid'));
    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);

      return UserModelCart.fromMap(map[AppConstants.fields]);
      // return users;
    } else {
      return null;
    }
  }

  Future<List<SupportModel>> getSupportsMessages({required String service}) async{
    http.Response response = await http.get(Uri.parse('${AppConstants.projectURI}$service${AppConstants.supportURI}'));
    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      List<SupportModel> supports = SupportModel().getSupports(map[AppConstants.documents]);

      return supports;
    } else {
      return [];
    }
  }

  Future<void> logout(BuildContext context) {
    return FirebaseAuth.instance.signOut().then((value) {
      snackBarDialog(context: context, title: 'Good Bye', message: "Logging Out.", isSuccess: true);
      Get.offAllNamed(RouteHelper.signIn);
    });
  }

  void setUserState(bool isOnline) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'isOnline': isOnline,
    });
  }


}

snackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg.toString())));
}
