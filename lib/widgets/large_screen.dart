import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  final Widget body;
  final String name;
  final String service;
  const LargeScreen({Key? key, required this.body, required this.name, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Expanded(child: SideMenu(name: name, service: service,)),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: body,
          ),
        )
      ],
    );
  }
}
