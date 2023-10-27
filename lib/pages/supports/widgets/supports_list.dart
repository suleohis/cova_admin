import 'package:cova_admin_dashboard/models/support_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/style.dart';
import '../../../functions/auth/authentication.dart';
import '../../../widgets/custom_text.dart';

class SupportsList extends StatelessWidget {
  final String service;
  const SupportsList({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Authentication().getSupportsMessages(service: service),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<SupportModel> supports = snapshot.data!;
          return ListView.builder(
            itemCount: supports.length,
            padding: const EdgeInsets.only(left: 30),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                // decoration: BoxDecoration(
                //     color: active, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: active, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          CustomText(
                            text: '${supports[index].subject!}\n',
                            size: 15,
                            color: Colors.white,
                            underLine: true,
                          ),
                          CustomText(
                            text: supports[index].message!,
                            size: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: '${supports[index].name}',
                            size: 15,
                          ),
                          CustomText(
                            text: '${supports[index].email}',
                            size: 15,
                          ),
                          CustomText(
                            text: DateFormat.yMMMMEEEEd()
                                .format(supports[index].date!),
                            size: 13,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
