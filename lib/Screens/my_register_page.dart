// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/Methods/my_show_snack_bar_method.dart';
import 'package:my_chat_app/Widgets/my_container_widget.dart';
import 'package:my_chat_app/Widgets/my_form_text_field_widget.dart';
import 'package:my_chat_app/my_constants.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});
  static String id = kRegisterPage;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  String? registrationEmaiL;
  String? registrationPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: Scaffold(
        backgroundColor: kPrimaryCoLor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryCoLor,
          centerTitle: true,
          title: Container(
            color: Colors.white,
            child: Text(
              "Register Page",
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryCoLor,
                fontFamily: "Pacifico",
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "SchoLar Chat",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Pacifico",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyFormTextFieLdWidget(
                    onChanged: (value) {
                      registrationEmaiL = value;
                    },
                    obscureText: false,
                    hintText: "EmaiL",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyFormTextFieLdWidget(
                    onChanged: (value) {
                      registrationPassword = value;
                    },
                    obscureText: true,
                    hintText: "Password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyContainerWidget(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        inAsyncCall = true;
                        setState(
                          () {},
                        );
                        try {
                          await myRegistrationMethod();
                          if (!context.mounted) return;
                          myShowSnackBarMethod(
                            context,
                            "SuccessfuLLy Registration.",
                          );
                          Navigator.pushNamed(context, kLoginPage);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            if (!context.mounted) return;
                            myShowSnackBarMethod(
                              context,
                              "The Password Provided Is Too Weak.",
                            );
                          } else if (e.code == 'email-already-in-use') {
                            if (!context.mounted) return;
                            myShowSnackBarMethod(
                              context,
                              "The Account ALready Exists For That EmaiL.",
                            );
                          }
                        } catch (e) {
                          log(e.toString());
                        }
                        inAsyncCall = false;
                        setState(
                          () {},
                        );
                      } else {}
                    },
                    textName: "Sign Up",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "ALready Have An Account?\t",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kLoginPage);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0XFFC7EDE6),
                            fontFamily: "Pacifico",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> myRegistrationMethod() async {
    UserCredential userRegistration =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: registrationEmaiL!,
      password: registrationPassword!,
    );
  }
}
