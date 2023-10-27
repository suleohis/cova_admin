import 'package:cova_admin_dashboard/functions/auth/authentication.dart';
import 'package:cova_admin_dashboard/models/support_model.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:cova_admin_dashboard/helpers/reponsiveness.dart';
import 'package:cova_admin_dashboard/constants/controllers.dart';
import 'package:cova_admin_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:cova_admin_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:cova_admin_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../../layout.dart';
import '../../models/user_modal.dart';
import '../users/widgets/users_table.dart';

class OverviewPage extends StatefulWidget {
  final String? name;
  final String serviceLink;
  final String serviceName;
  const OverviewPage({super.key, this.name = AppConstants.overview, required this.serviceLink, required this.serviceName});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int userCount = 0;
  int supportCount = 0;
  @override
  void initState() {
    getCounts();
    super.initState();
  }
  
  getCounts() async {
    List<UserModel> users = await Authentication().getAllUsers(service: widget.serviceLink);
    if (AppConstants.zenithlinkCollection != widget.serviceLink) {
      List<SupportModel> supports = await Authentication()
          .getSupportsMessages(service: widget.serviceLink);
      supportCount = supports.length;
    }

    
    userCount = users.length;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<UsersController>(
    //   builder: (userController) {
        return ScaffoldBody(
          service: widget.serviceName,
          name: widget.name!,
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
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                      if (ResponsiveWidget.isCustomSize(context))   OverviewCardsMediumScreen(
                        users: userCount,
                        support: supportCount,
                        serviceUrl: widget.serviceLink,
                      ) else  OverviewCardsLargeScreen(
                        users: userCount,
                        support: supportCount,
                        serviceUrl: widget.serviceLink,
                      )
                    else
                       OverviewCardsSmallScreen(
                        users: userCount,
                        support: supportCount,
                         serviceUrl: widget.serviceLink,
                      ),
                    // if (!ResponsiveWidget.isSmallScreen(context)) const RevenueSectionLarge() else const RevenueSectionSmall(),
                    const SizedBox(
                      height: 24,
                    ),
                    UsersTable(service: widget.serviceLink,),
                  ],
                ),
              ),
            ],
          ),
        );
    //   }
    // );
  }
}
