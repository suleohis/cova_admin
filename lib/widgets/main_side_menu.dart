import 'package:cova_admin_dashboard/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../constants/controllers.dart';
import '../constants/style.dart';
import '../functions/auth/authentication.dart';
import '../helpers/reponsiveness.dart';
import '../routing/routes.dart';
import 'custom_text.dart';

class MainSideMenuItem extends StatelessWidget {
  final String? itemName;
  final String? name;
  final List<MenuItem>? subMenu;
  final bool isActive;
  final String service;
  const MainSideMenuItem({Key? key, this.itemName, this.subMenu, this.name, this.isActive = false, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      maintainState: true,
      initiallyExpanded: menuController.isActiveService(itemName!),

      title: Row(
        children: [
          // Visibility(
          //   visible: isActive,
          //   maintainSize: true,
          //   maintainAnimation: true,
          //   maintainState: true,
          //   child: Container(
          //     width: 6,
          //     height: 40,
          //     color: dark,
          //   ),
          // ),
          Flexible(
              child: CustomText(
                text: itemName!,
                color: menuController.isHoveringService(itemName!)
                    ? Colors.white
                    : lightGrey,
              )),
        ],
      ),
      onExpansionChanged: (value) {
        // if (!menuController.isActive(itemName!)) {
        //   menuController.changeActiveServiceTo(itemName!);
        // }
      },
      children: subMenu!.map((item) {
        Future.delayed(const Duration(milliseconds: 1), () {
          if(menuController.isActive(item.name!) || menuController.activeService.value == '') {
            // print(name);
            // print(item.name);
            // if(menuController.activeService.value == '') {
            //   print('sdf');
            //   menuController.changeActiveServiceTo(itemName!);
            // }
            if (name != item.name) {
              menuController.changeActiveItemTo(name!);
              menuController.changeActiveServiceTo(itemName!);
            }
          }
        });
        return SideMenuItem(
            itemName: item.name!,
            mainItemName: itemName!,
            icon: item.icon!,
            service: service,
            onTap: () {
              if(item.route == RouteHelper.signIn){
                Authentication().logout(context);
                menuController.changeActiveItemTo(AppConstants.overview);

              }

              // if (!menuController.isActive(item.name!) || menuController.activeItem.value == '') {
                menuController.changeActiveItemTo(item.name!);
                menuController.changeActiveServiceTo(itemName!);
                if(ResponsiveWidget.isSmallScreen(context)) {
                  Get.back();
                }
                navigationController.navigateTo(item.route!,);
              // }
            });
      })
          .toList(),
    );
  }
}
