import 'package:cova_admin_dashboard/pages/cart/widgets/carts_table.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';

import '../../constants/constants.dart';
import '../../helpers/reponsiveness.dart';
import '../../layout.dart';

class CartsPage extends StatelessWidget {
  final String uid;
  final String serviceLink;
  final String serviceName;
  const CartsPage({ Key? key, required this.uid, required this.serviceLink, required this.serviceName }) : super(key: key);

  @override
  Widget build(BuildContext context) {
         return ScaffoldBody(
           service: serviceName,
           name: AppConstants.cart,
           body: Column(
           children: [
             Row(
               children: [
                 Container(
                   margin: EdgeInsets.only(top:
                   ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                   child: const CustomText(text: AppConstants.cart, size: 24, weight: FontWeight.bold,)),
               ],
             ),

             Expanded(child: ListView(
               children:  [
                 CartsTable(uid: uid, service: serviceLink,),
               ],
             )),

             ],
           ),
         );
  }
}