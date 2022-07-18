import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chat_room_screen.dart';
import 'package:chat_app/views/sign_in.dart';
import 'package:flutter/material.dart';

import '../widget/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  const SignUp(this.toggle, {Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passswordTextEditingController =
      TextEditingController();
  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  signMeUp() {
    if (formKey.currentState!.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text,
      };

      HelperFunction.saveUserNameSharedPreferences(
          usernameTextEditingController.text);
      HelperFunction.saveUserEmailSharedPreferences(
          emailTextEditingController.text);
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passswordTextEditingController.text)
          .then((value) {
        HelperFunction.saveUserLoggedInSharedPreferences(true);
        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ChatRoom()));
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
      body: isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                                  return value!.isEmpty || value.length < 2
                                      ? "Please provide a valid UserName"
                                      : null;
                                },
                                controller: usernameTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textInputDecoration('UserName'),
                              ),
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
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                        onPressed: signMeUp,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: const StadiumBorder()),
                        child: Text(
                          'Sign Up',
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
                            'Sign Up with Google',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: simpleTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle;
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Authenticate()));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  "Sign In now",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
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
