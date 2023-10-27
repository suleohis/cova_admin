import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../functions/auth/authentication.dart';
import '../functions/users/function.dart';
import '../models/user_modal.dart';

class UsersController extends GetxController{
  static UsersController instance = Get.find();
  List<UserModel>? users;
  UserModel? userModel;

  // UsersController({this.users, this.userModel});



 getUser() async {
    userModel =
        UserModel.fromSnapshot(await Authentication().getCurrentUserData2());
    // print(userModel!.username);
    update();
  }

  getAllUsers() async {
   QuerySnapshot<Map<String, dynamic>> snapshot =  await FirebaseFirestore.instance
       .collection(AppConstants.usersCollection).get();

   users = UsersFunction().getUserDocs(snapshot.docs);
   // print(users);
   update();
  }
}