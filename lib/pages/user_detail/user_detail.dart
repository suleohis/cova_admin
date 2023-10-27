import 'package:cova_admin_dashboard/models/user_modal.dart';
import 'package:cova_admin_dashboard/pages/cart/widgets/carts_table.dart';
import 'package:flutter/material.dart';

import '../../functions/auth/authentication.dart';

class UserDetailPage extends StatelessWidget {
  final String? uid;
  final String serviceLink;
  final String serviceName;
  const UserDetailPage({Key? key, required this.uid, required this.serviceLink, required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FutureBuilder(
            future: Authentication().getUserCart(uid!, service: serviceLink),
            builder: (context, AsyncSnapshot<UserModel?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // DocumentSnapshot<Map<String, dynamic>>? docSnap = snapshot.data!;
              UserModel user = snapshot.data!;
            return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        user.username!,
                        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(user.email!),
                      const SizedBox(
                        height: 20,
                      ),
                      CartsTable(uid: uid!, service: serviceLink,)
                    ],
                  ),
                ));
          }
        ));
  }
}
