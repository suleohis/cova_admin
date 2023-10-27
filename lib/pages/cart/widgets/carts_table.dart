import 'package:cova_admin_dashboard/models/cart_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/style.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';

import '../../../functions/auth/authentication.dart';

/// Example without datasource
class CartsTable extends StatelessWidget {
  final String uid;
  final String service;
  const CartsTable({super.key, required this.uid, required this.service});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Authentication().getUserCart(uid, service: service),
        builder: (context, AsyncSnapshot<UserModelCart?> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {

            return Container();
          }

          // DocumentSnapshot<Map<String, dynamic>>? docSnap = ;
          UserModelCart user = snapshot.data!;
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
                  columns: const [
                    DataColumn2(
                      label: Text("Name"),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Price'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                      user.carts!.length,
                          (index) => DataRow(cells: [
                        DataCell(CustomText(text: user.carts![index].planName!)),
                        DataCell(CustomText(text:user.carts![index].planPrice!)),
                      ]))),
            ),
          );
        }
    );
  }
}
