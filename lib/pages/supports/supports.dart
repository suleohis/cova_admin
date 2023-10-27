import 'package:cova_admin_dashboard/layout.dart';
import 'package:cova_admin_dashboard/pages/supports/widgets/supports_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class SupportsPages extends StatelessWidget {
  final String serviceLink;
  final String serviceName;
  const SupportsPages({Key? key, required this.serviceLink, required this.serviceName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScaffoldBody( name: AppConstants.supports,
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
              child: SupportsList(service: serviceLink,)),
        ],
      ),
    );
  }
}
