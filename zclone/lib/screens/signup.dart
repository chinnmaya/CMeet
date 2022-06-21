import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zclone/screens/sign_in.dart';
import 'package:zclone/utils/colors.dart';
import '/resources/auth_methods.dart';
import '/screens/home_screen.dart';
import '../resources/auth_methods.dart';

class signup extends StatefulWidget {
  //const signin({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  //Auth auth = new Auth();
  AuthMethods authMethods = new AuthMethods();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool cirecular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN UP",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 75,
              )),
              SizedBox(
                height: 15,
              ),
              take_item(_email),
              SizedBox(
                height: 15,
              ),
              pass(_pass),
              SizedBox(
                height: 15,
              ),
              colorbtn(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont have an account?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => signin()),
                          (route) => false);
                    },
                    child: Text(
                      "SIGN IN?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget take_item(TextEditingController controller) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width - 70,
      child: TextFormField(
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          labelText: "Email...",
          labelStyle: TextStyle(fontSize: 17, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorbtn() {
    return InkWell(
      onTap: () async {
        try {
          setState(() {
            cirecular = true;
          });
          bool result =
              await authMethods.createuser(context, _email.text, _pass.text);
          if (result == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => HomeScreen()),
                (route) => false);
          }
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            cirecular = false;
          });
        }
      },
      child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 90,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: cirecular
                ? CircularProgressIndicator()
                : Text(
                    "SIGN UP",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
          )),
    );
  }

  Widget pass(TextEditingController controller) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width - 70,
      child: TextFormField(
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "password...",
          labelStyle: TextStyle(fontSize: 17, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1.5, color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
