import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/helpers/reponsiveness.dart';
import 'package:cova_admin_dashboard/widgets/horizontal_menu_item.dart';
import 'package:cova_admin_dashboard/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final String mainItemName;
  final String service;
  final Function() onTap;
  final IconData icon;

  const SideMenuItem({Key? key, required this.itemName, required this.mainItemName, required this.service, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VertticalMenuItem(
        itemName: itemName,
        onTap: onTap,
        icon: icon,
        isService: service == mainItemName,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
        icon: icon,
        isService: service == mainItemName,
      );
    }
  }
}
