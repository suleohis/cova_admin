import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  final int? users;
  final int? support;
  final String serviceUrl;
  const OverviewCardsSmallScreen(
      {super.key,
      required this.users,
      required this.support,
      required this.serviceUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Users",
            value: users.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: width / 48,
          ),
          // InfoCardSmall(
          //   title: "Orders",
          //   value: orders.toString(),
          //   onTap: () {},
          // ),
          // SizedBox(
          //   height: width / 48,
          // ),
          if (serviceUrl != AppConstants.zenithlinkCollection)
            InfoCardSmall(
              title: "Support Messages",
              value: support.toString(),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
