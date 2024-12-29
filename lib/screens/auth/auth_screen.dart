import 'package:carpark/screens/auth/forgot_password.dart';
import 'package:carpark/screens/auth/signup_screen.dart';
import 'package:carpark/screens/pages/main_dashboard.dart';
import 'package:carpark/services/auth_methods.dart';
import 'package:carpark/utils/colors.dart';
import 'package:carpark/utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            width: 240,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _emailController,
                  style: GoogleFonts.plusJakartaSans(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: borderColor,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      hintText: "Enter Email Address",
                      hintStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.black, fontSize: 12)),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  obscureText: !showPassword,
                  controller: _passwordController,
                  style: GoogleFonts.plusJakartaSans(color: Colors.black),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: toggleShowPassword,
                        icon: showPassword
                            ? Icon(Icons.visibility_off, color: grey)
                            : Icon(Icons.visibility, color: grey),
                      ),
                      filled: true,
                      fillColor: borderColor,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      hintText: "Enter Password",
                      hintStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.black, fontSize: 12)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Remember Me',
                      style: GoogleFonts.plusJakartaSans(
                          color: grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ForgotPassword()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.workSans(color: mainBtnColor),
                    ))
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showMessageBar(
                            "Email and Password are required", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          // Log in the user and get their data
                          await AuthMethods().loginUpUser(
                            email: _emailController.text.trim(),
                            pass: _passwordController.text.trim(),
                          );

                          setState(() {
                            isLoading = false;
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()),
                          );
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          showMessageBar("Error: ${e.toString()}", context);
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.workSans(
                          color: colorwhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: mainBtnColor,
                        fixedSize: Size(379, 50)),
                  )),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => SignupScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(TextSpan(
                  text: 'Don’t have an account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Sign Up',
                      style: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainBtnColor),
                    )
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  //Password Toggle Function
  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }
}
