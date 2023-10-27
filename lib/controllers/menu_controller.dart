import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../constants/style.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = ''.obs;

  var activeService = ''.obs;

  var hoverItem = "".obs;

  var hoverService = "".obs;

  changeActiveItemTo(String itemName) {

      if (itemName == AppConstants.cart) {
        activeItem.value = AppConstants.users;
      } else {
        activeItem.value = itemName;
      }

  }

  changeActiveServiceTo(String serviceName) {
    activeService.value = serviceName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) {
      if (itemName == AppConstants.cart) {
        hoverItem.value = AppConstants.users;
      } else {
        hoverItem.value = itemName;
      }
    }
  }

  onHoverService(String serviceName) {
    if (!isActive(serviceName)) hoverService.value = serviceName;
  }

  isHovering(String itemName) {
    if (itemName == AppConstants.cart) {
      return hoverItem.value == AppConstants.users;

    } else {
      return hoverItem.value == itemName;
    }
  }

  isHoveringService(String serviceName) => hoverService.value == serviceName;

  isActive(String itemName) {
    if (itemName == AppConstants.cart) {
      return activeItem.value == AppConstants.users;
    } else {
      return activeItem.value == itemName;
    }
  }

  isActiveService(String serviceName) => activeService.value == serviceName;



  Widget customIcon(IconData icon, String itemName, bool isService) {
    if (isActive(itemName )&& isService)  return Icon(icon, size: 22, color: dark);

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
