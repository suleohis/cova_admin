import 'package:cova_admin_dashboard/functions/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:cova_admin_dashboard/constants/style.dart';
import 'package:cova_admin_dashboard/routing/routes.dart';
import 'package:cova_admin_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../functions/snackbar.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png", height: 50, width: 150,),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  CustomText(
                    text: "Welcome back to the admin panel.",
                    color: lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // Row(
              //     //   children: [
              //     //     Checkbox(value: true, onChanged: (value){}),
              //     //     const CustomText(text: "Remeber Me",),
              //     //   ],
              //     // ),
              //     Container(),
              //     const CustomText(text: "Forgot password?", color: active)
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              InkWell(
                onTap: () {
                  Authentication()
                      .signIn(emailController.text, passwordController.text,
                          context)
                      .then((value) {
                    if (value) {
                      snackBarDialog(
                          context: context,
                          title: 'Welcome Back',
                          message: 'Logging In Successful.',
                          isSuccess: true);
                      Get.offAllNamed(RouteHelper.getInitialRoute());
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: active, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // RichText(text: const TextSpan(
              //   children: [
              //     TextSpan(text: "Do not have admin credentials? "),
              //     TextSpan(text: "Request Credentials! ", style: TextStyle(color: active))
              //   ]
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
