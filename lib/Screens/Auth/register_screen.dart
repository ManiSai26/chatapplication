import 'package:chatapplication/Screens/Auth/login_screen.dart';
import 'package:chatapplication/Screens/home_screen.dart';
import 'package:chatapplication/Widgets/widgets.dart';
import 'package:chatapplication/helper/helper_function.dart';
import 'package:chatapplication/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  String email = "", password = "", fullName = "";
  bool _isLoading = false;
  AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Groupie",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Create Your Account now to chat and explore",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Image.asset("assets/register.png"),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFFee7b64),
                          ),
                          labelText: "Full Name",
                        ),
                        onChanged: (val) {
                          setState(() {
                            fullName = val;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) return "Enter Full Name";
                          return null;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFFee7b64),
                          ),
                          labelText: "Email",
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "please Enter a valid Email";
                        },
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFFee7b64),
                          ),
                          labelText: "Password",
                        ),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password is too Short";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Login here",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, LoginScreen());
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async => {
                if (value == true)
                  {
                    await HelperFunctions.saveLoggedInStatus(true),
                    await HelperFunctions.saveUserEmailSF(email),
                    await HelperFunctions.saveUserNameSF(fullName),
                    setState(() {
                      _isLoading = false;
                    }),
                    nextScreenReplacement(context, HomeScreen())
                  }
                else
                  {
                    showSnackBar(context, Colors.red, value),
                    setState(() {
                      _isLoading = false;
                    })
                  }
              });
    }
  }
}
