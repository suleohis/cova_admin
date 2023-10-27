import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:cova_admin_dashboard/constants/style.dart';

import 'widgets/custom_text.dart';

class VertticalMenuItem extends StatelessWidget {
  final String itemName;
  final bool  isService;
  final IconData icon;
  final Function()? onTap;
  const VertticalMenuItem({Key? key, required this.itemName,required this.isService, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
              color: menuController.isHovering(itemName)
                  ? lightGrey.withOpacity(.1)
                  : Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: (menuController.isHovering(itemName) ||
                        menuController.isActive(itemName) ) && isService,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: 3,
                      height: 72,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: menuController.customIcon(icon,itemName, isService),
                        ),
                        if (!menuController.isActive(itemName) && isService)
                          Flexible(
                              child: CustomText(
                            text: itemName,
                            color: menuController.isHovering(itemName)
                                ? Colors.white
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
                  ),
                ],
              ),
            )));
  }
}
