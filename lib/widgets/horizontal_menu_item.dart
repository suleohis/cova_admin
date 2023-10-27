import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:cova_admin_dashboard/constants/style.dart';

import '../constants/constants.dart';
import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final bool isService;
  final IconData icon;
  final Function()? onTap;
  const HorizontalMenuItem(
      {Key? key, required this.itemName, required this.isService,  required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
              color: itemName == AppConstants.logOut ? active :  menuController.isHovering(itemName)
                  ? lightGrey.withOpacity(.1)
                  : Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: (menuController.isHovering(itemName) ||
                        menuController.isActive(itemName)) && isService,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: 6,
                      height: 40,
                      color: dark,
                    ),
                  ),
                  SizedBox(width: width / 88),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: menuController.customIcon(icon, itemName, isService),
                  ),
                  if (!menuController.isActive(itemName) )
                    Flexible(
                        child: CustomText(
                      text: itemName,
                      color: menuController.isHovering(itemName) && isService
                          ? dark
                          : lightGrey,
                    ))
                  else
                    Flexible(
                        child: CustomText(
                      text: itemName,
                      color: !isService ? lightGrey : dark,
                      size: !isService ? 16 : 18,
                      weight: !isService ? FontWeight.normal : FontWeight.bold,
                    ))
                ],
              ),
            )));
  }
}
