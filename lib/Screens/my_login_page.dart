// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/Methods/my_show_snack_bar_method.dart';
import 'package:my_chat_app/Widgets/my_container_widget.dart';
import 'package:my_chat_app/Widgets/my_form_text_field_widget.dart';
import 'package:my_chat_app/my_constants.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});
  static String id = kLoginPage;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  String? loginEmaiL;
  String? loginPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      child: Scaffold(
        backgroundColor: kPrimaryCoLor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryCoLor,
          centerTitle: true,
          title: Container(
            color: Colors.white,
            child: Text(
              "Login Page",
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
                    "Sign In",
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
                      loginEmaiL = value;
                    },
                    obscureText: false,
                    hintText: "EmaiL",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyFormTextFieLdWidget(
                    onChanged: (value) {
                      loginPassword = value;
                    },
                    obscureText: true,
                    hintText: "Password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyContainerWidget(
                    textName: "Sign In",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        inAsyncCall = true;
                        setState(
                          () {},
                        );
                        try {
                          await myLoginMethod();
                          if (!context.mounted) return;
                          myShowSnackBarMethod(
                            context,
                            "SuccessfuLLy Login.",
                          );
                          Navigator.pushNamed(context, kChatPage,
                              arguments: loginEmaiL);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            myShowSnackBarMethod(
                              context,
                              "No User Found For That EmaiL.",
                            );
                          } else if (e.code == 'wrong-password') {
                            myShowSnackBarMethod(
                              context,
                              "Wrong Password Provided For That User.",
                            );
                          }
                        } catch (e) {
                          log(
                            e.toString(),
                          );
                        }
                        inAsyncCall = false;
                        setState(
                          () {},
                        );
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have An Account?\t",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRegisterPage);
                        },
                        child: const Text(
                          "Sign Up",
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

  Future<void> myLoginMethod() async {
    UserCredential userLogin =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEmaiL!,
      password: loginPassword!,
    );
  }
}
