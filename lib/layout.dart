import 'package:cova_admin_dashboard/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/widgets/large_screen.dart';
import 'package:cova_admin_dashboard/widgets/side_menu.dart';

import 'helpers/reponsiveness.dart';
import 'widgets/top_nav.dart';




class ScaffoldBody extends StatefulWidget {
  final Widget body;
  final String name;
  final String service;

  const ScaffoldBody({super.key, required this.body, required this.name, required this.service});

  @override
  State<ScaffoldBody> createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void initState() {
    UsersController().getUser();
    UsersController().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer:  Drawer(
        child: SideMenu(name: widget.name,service: widget.service, ),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(body: widget.body, name: widget.name, service: widget.service,),
      smallScreen: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: widget.body,
      )
      ),
    );

  }
  // getUser() async {
  //   userModel =
  //       UserModel.fromSnapshot(await Authentication().getCurrentUserData2());
  //
  //   setState(() {});
  // }
}


