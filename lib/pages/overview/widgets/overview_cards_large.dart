import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/pages/overview/widgets/info_card.dart';

import '../../../constants/constants.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final int? users;
  final int? support;
  final String serviceUrl;
  const OverviewCardsLargeScreen(
      {super.key,
      required this.users,
      required this.support,
      required this.serviceUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "Users",
          value: users.toString(),
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          height: width / 48,
        ),
        // InfoCard(
        //   title: "Orders",
        //   value: orders.toString(),
        //   onTap: () {},
        //   topColor: Colors.lightGreen,
        // ),
        // SizedBox(
        //   height: width / 48,
        // ),

        if (serviceUrl == AppConstants.cloudServiceCollection)
          InfoCard(
            title: "Support Messages",
            value: support.toString(),
            onTap: () {},
            topColor: Colors.redAccent,
          ),
      ],
    );
  }
}
