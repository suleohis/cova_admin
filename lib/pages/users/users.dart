import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:cova_admin_dashboard/constants/controllers.dart';
import 'package:cova_admin_dashboard/helpers/reponsiveness.dart';
import 'package:cova_admin_dashboard/pages/users/widgets/users_table.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../../layout.dart';

class UsersPage extends StatelessWidget {
  final String serviceLink;
  final String serviceName;
  const UsersPage({Key? key, required this.serviceLink, required this.serviceName }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBody(
      name: AppConstants.users,
      service: serviceName,
      body: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children:  [UsersTable(service: serviceLink,)],
          )),
        ],
      ),
    );
  }
}
