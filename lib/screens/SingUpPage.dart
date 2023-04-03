import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../modal/firebase_auth_helper.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: signUpFormKey,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                width: 200,
                height: 100,
                child: Image.asset("assets/images/notpad.png"),
              ),
              Text(
                "Notpad",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sing-Up",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 25,
                  bottom: 15,
                ),
                child: TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter email first....";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: TextFormField(
                  controller: passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter password....";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF2CB6B),
                  minimumSize: Size(350, 50),
                ),
                onPressed: () async {
                  if (signUpFormKey.currentState!.validate()) {
                    signUpFormKey.currentState!.save();
                  }

                  Map<String, dynamic> res = await FirebaseAuthHelper
                      .firebaseAuthHelper
                      .singUp(email: email!, password: password!);

                  if (res['user'] != null) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                            "Login successful...",
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating),
                    );
                    Navigator.of(context).pushNamed('login');
                  } else if (res['error'] != null) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(res['error']),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ), // SnackBar
                    );
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                            "Sign Up failed...",
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating),
                    );
                  }
                  setState(() {
                    emailController.clear();
                    passwordController.clear();

                    email = null;
                    password = null;
                  });
                },
                child: Text(
                  "Sing-Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    color: Color(0xff76614A),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: () async {
                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .singWithGoogle();

                      if (res['user'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Login successful...",
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating),
                        );
                        Navigator.of(context).pushReplacementNamed('/');
                      } else if (res['error'] != null) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(res['error']),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ), // SnackBar
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Login failed...",
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating),
                        );
                      }
                      setState(() {
                        emailController.clear();
                        passwordController.clear();

                        email = null;
                        password =null;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                              "assets/images/google-icon-logo.png"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: () async {
                      User? user = await FirebaseAuthHelper.firebaseAuthHelper
                          .signInAnonymously();

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Login successful...",
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating),
                        );
                        Navigator.of(context).pushReplacementNamed('/');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Login failed...",
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating),
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Anonymous",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
