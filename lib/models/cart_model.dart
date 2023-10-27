import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:cova_admin_dashboard/models/user_modal.dart';

class CartModel {
  String? planName;
  String? planPrice;

  CartModel({this.planName, this.planPrice});

  factory CartModel.fromSnap(Map<String, dynamic> map) {
    return CartModel(
      planName: map[AppConstants.mapValue][AppConstants.fields][AppConstants.planName][AppConstants.stringValue],
      planPrice: map[AppConstants.mapValue][AppConstants.fields][AppConstants.planPrice][AppConstants.stringValue],
    );
  }
  
  List<CartModel> getCarts(List<dynamic> list) {
    List<CartModel> carts = [];
    for(var map in list) {
      carts.add(CartModel.fromSnap(map));
    }
    return carts;
  }
}

class UserModelCart extends UserModel {
  List<CartModel>? carts;
  UserModelCart(
      {super.uid,
      super.username,
      super.email,
      super.createdAt,
      super.signInAt,
      super.role,
      this.carts});

  factory UserModelCart.fromMap(Map<String, dynamic> map) {

    UserModelCart userModelCart = UserModelCart(
        uid: map[AppConstants.uid][AppConstants.stringValue] ?? '',
        username: map[AppConstants.username][AppConstants.stringValue] ?? '',
        email: map[AppConstants.email][AppConstants.stringValue],
        createdAt:
            DateTime.parse(map[AppConstants.createdAt][AppConstants.timestampValue]),
        signInAt:
            DateTime.parse(map[AppConstants.signInAt][AppConstants.timestampValue]),
        role: map[AppConstants.role][AppConstants.stringValue],
        carts: CartModel().getCarts(map[AppConstants.carts][AppConstants.arrayValue][AppConstants.values])
    );
    return userModelCart;
  }
  List<UserModelCart> getUsersCart(List snapshot) {
    List<UserModelCart> users = [];
    for (var element in snapshot) {
      UserModelCart user = UserModelCart(
        uid: element[AppConstants.fields][AppConstants.uid][AppConstants.stringValue] ?? '',
        username: element[AppConstants.fields][AppConstants.username][AppConstants.stringValue] ?? '',
        email: element[AppConstants.fields][AppConstants.email][AppConstants.stringValue],
        createdAt: DateTime.parse(element[AppConstants.fields][AppConstants.createdAt][AppConstants.timestampValue]),
        signInAt: DateTime.parse(element[AppConstants.fields][AppConstants.signInAt][AppConstants.timestampValue]),
        // // imageUrl: element[AppConstants.imageUrl],
        role: element[AppConstants.fields][AppConstants.role][AppConstants.stringValue],
        carts: element[AppConstants.fields][AppConstants.carts][AppConstants.arrayValue]
      );
      users.add(user);
    }
    return users;
  }
}
