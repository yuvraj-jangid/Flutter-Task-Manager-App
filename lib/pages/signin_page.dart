import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/Service/Auth_Service.dart';
import 'package:task_manager_app/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'HomePage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SigninPage> {
  static firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 103, 139, 29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign in",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              ButtonItem("assets/google.svg", "Continue with Google", 25, () {
                authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 5,
              ),
              ButtonItem("assets/phone.svg", "Continue with Phone", 25, () {}),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "OR",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              textItem("E-mail", _emailController, false),
              const SizedBox(
                height: 10,
              ),
              textItem("Password", _pwdController, true),
              const SizedBox(
                height: 20,
              ),
              colorButton(),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => SignupPage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      "Sign up!",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 51, 33, 243),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonItem(
      String imagepath, String buttonName, double size, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: const Color.fromARGB(255, 3, 66, 87),
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1, color: Colors.black)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1.5, color: Colors.amber)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user);

          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builder) => HomePage(),
              ),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ])),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          circular
              ? CircularProgressIndicator()
              : Text(
                  "Sign in",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
          const SizedBox(
            width: 15,
          ),
          SvgPicture.asset(
            "assets/arrow.svg",
            height: 25,
            width: 25,
          ),
        ]),
      ),
    );
  }
}
