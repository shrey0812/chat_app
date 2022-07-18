import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chat_room_screen.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/helper_function.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn(this.toggle, {Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passswordTextEditingController =
      TextEditingController();
  dynamic snapshotUserInfo;

  bool isLoading = false;

  signIn() {
    if (formKey.currentState!.validate()) {
      HelperFunction.saveUserEmailSharedPreferences(
          emailTextEditingController.text);
      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((value) {
        snapshotUserInfo = value;
        HelperFunction.saveUserNameSharedPreferences(
            snapshotUserInfo.document[0].data['name']);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassoword(emailTextEditingController.text,
              passswordTextEditingController.text)
          .then((value) {
        if (value != null) {
          HelperFunction.saveUserLoggedInSharedPreferences(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: appBarMain(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 90,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value.toString())
                              ? null
                              : 'Please provide a valid Email address';
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textInputDecoration('Email'),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          return value!.length < 6
                              ? " Weak Password.\nThe Password must be more than 6 characters "
                              : null;
                        },
                        controller: passswordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textInputDecoration('Password'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Forgot Password?',
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: const StadiumBorder()),
                  child: Text(
                    'Sign In',
                    style: simpleTextStyle(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: const StadiumBorder(),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50)),
                    onPressed: () {},
                    child: const Text(
                      'Sign In with Google',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: simpleTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Register now",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
