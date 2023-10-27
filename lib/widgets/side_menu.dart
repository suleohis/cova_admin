import 'package:cova_admin_dashboard/functions/auth/authentication.dart';
import 'package:cova_admin_dashboard/widgets/main_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:cova_admin_dashboard/constants/controllers.dart';
import 'package:cova_admin_dashboard/constants/style.dart';
import 'package:cova_admin_dashboard/helpers/reponsiveness.dart';
import 'package:cova_admin_dashboard/routing/routes.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';
import 'package:cova_admin_dashboard/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  final String name;
  final String service;
  const SideMenu({ Key? key, required this.name, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    return Container(
            color: light,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      if(ResponsiveWidget.isSmallScreen(context))
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width / 48),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Image.asset("assets/icons/logo.png"),
                              ),
                              const Flexible(
                                child: CustomText(
                                  text: "HostKing",
                                  size: 20,
                                  weight: FontWeight.bold,
                                  color: active,
                                ),
                              ),
                              SizedBox(width: width / 48),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                          Divider(color: lightGrey.withOpacity(.1), ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: sideMenuItemRoutes
                            .map((item) {

                              return MainSideMenuItem(
                                itemName: item.name!,
                                name: name,
                                subMenu: item.sideMenu,
                                service: service,
                                isActive: menuController.isActiveService(item.name!),
                              );
                            } )
                            .toList(),
                      )
                    ],
                  ),
                ),

                SideMenuItem(
                    itemName: logout.name!,
                    mainItemName: '',
                    icon: logout.icon!,
                    service: service,
                    onTap: () {
                      if(logout.route == RouteHelper.signIn){
                        Authentication().logout(context);
                        menuController.changeActiveItemTo(AppConstants.overview);
                      }
                    })
              ],
            ),
          );
  }
}