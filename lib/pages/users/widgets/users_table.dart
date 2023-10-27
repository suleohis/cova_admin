import 'package:cova_admin_dashboard/constants/constants.dart';
import 'package:cova_admin_dashboard/functions/auth/authentication.dart';
import 'package:cova_admin_dashboard/models/user_modal.dart';
import 'package:cova_admin_dashboard/routing/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/style.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class UsersTable extends StatelessWidget {
  final String service;
  const UsersTable({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authentication().getAllUsers(service: service),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<UserModel> users = snapshot.data!;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: active.withOpacity(.4), width: .5),
            boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
            height: (60 * 7) + 40,
            child: DataTable2(
                columnSpacing: 12,
                dataRowHeight: 60,
                headingRowHeight: 40,
                horizontalMargin: 12,
                minWidth: 600,
                columns:  [
                  const DataColumn2(
                    label: Text("Username"),
                    size: ColumnSize.L,
                  ),
                  const DataColumn(
                    label: Text('Email'),
                  ),
                  const DataColumn(
                    label: Text('Created At'),
                  ),
                  const DataColumn(
                    label: Text('Sign In At'),
                  ),
                  if(service !=  AppConstants.zenithlinkCollection)
                  const DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    users.length,
                    (index) {
                      return DataRow(cells: [
                      DataCell(CustomText(text: users[index].username!)),
                      DataCell(CustomText(text:users[index].email!)),

                      DataCell(CustomText(text:DateFormat.yMMMMEEEEd().format(users[index].createdAt!), size: 13,)),
                      DataCell(CustomText(text:DateFormat.yMMMMEEEEd().format(users[index].signInAt!), size: 13,)),

                        if(service !=  AppConstants.zenithlinkCollection)
                          DataCell(GestureDetector(
                            onTap: () => Get.toNamed(RouteHelper.getCartRoute(RouteHelper.getUsersRoute(RouteHelper.cloudService), users[index].uid!  )),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: light,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: active, width: .5),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: CustomText(
                                  text: "View Carts",
                                  color: active.withOpacity(.7),
                                  weight: FontWeight.bold,
                                )),
                          )),
                        ]);
                    })),
          ),
        );
      }
    );
  }
}
