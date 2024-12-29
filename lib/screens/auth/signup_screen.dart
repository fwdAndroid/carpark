import 'package:carpark/screens/auth/auth_screen.dart';
import 'package:carpark/screens/pages/main_dashboard.dart';
import 'package:carpark/services/auth_methods.dart';
import 'package:carpark/utils/colors.dart';
import 'package:carpark/utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: GoogleFonts.workSans()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
            ),
            Text(
              "Hello User!",
              style: GoogleFonts.workSans(
                  fontSize: 22, color: black, fontWeight: FontWeight.w600),
            ),
            Text(
              "Create your account for \n better Experience",
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                  fontSize: 16, color: grey, fontWeight: FontWeight.w300),
            ),
            buildTextField(
              controller: _nameController,
              hintText: "Enter Full Name",
            ),
            buildTextField(
              controller: _emailController,
              hintText: "Enter Email Address",
            ),
            buildPasswordField(),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildRegisterButton(context),
            buildSignInPrompt(context),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.plusJakartaSans(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: borderColor,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          hintText: hintText,
          hintStyle:
              GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextFormField(
        obscureText: !showPassword,
        controller: _passwordController,
        style: GoogleFonts.plusJakartaSans(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: toggleShowPassword,
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: grey,
            ),
          ),
          filled: true,
          fillColor: borderColor,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          hintText: "Enter Password",
          hintStyle:
              GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_nameController.text.isEmpty) {
            showMessageBar("Name is required", context);
          } else if (_emailController.text.isEmpty) {
            showMessageBar("Email is required", context);
          } else if (_passwordController.text.isEmpty) {
            showMessageBar("Password is required", context);
          } else {
            setState(() {
              isLoading = true;
            });
            try {
              String result = await AuthMethods().signUpUser(
                email: _emailController.text.trim(),
                pass: _passwordController.text.trim(),
                username: _nameController.text.trim(),
              );
              setState(() {
                isLoading = false;
              });

              if (result == 'success') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (builder) => MainDashboard()),
                );

                showMessageBar("Registration Complete", context);
              } else {
                showMessageBar(result, context);
              }
            } catch (e) {
              setState(() {
                isLoading = false;
              });
              showMessageBar("Error: $e", context);
            }
          }
        },
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: mainBtnColor,
          fixedSize: const Size(379, 50),
        ),
      ),
    );
  }

  Widget buildSignInPrompt(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => AuthScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            children: <InlineSpan>[
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: mainBtnColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
