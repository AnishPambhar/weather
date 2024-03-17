import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_navigator/login.dart';
import 'package:life_navigator/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
          email: _emailController.text.toString(), password: _passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return Login();
            }));
      }).onError(
            (error, stackTrace) {
          Utils().toastmasg(error.toString());
          setState(
                () {
              loading = false;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/logo1.png",
                  color: Colors.black,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                buildTextField('Email', Icons.email, _emailController),
                buildPasswordField(
                    'Password', Icons.lock, _passwordController,_isPasswordVisible),
                buildPasswordField('Confirm Password', Icons.lock,
                    _confirmPasswordController,_isConfirmPasswordVisible),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 40, right: 40, bottom: 10),
                  child: Container(
                    height: 56,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff808080),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: signup,
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              fontFamily: "Montserrat")),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                buildDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 35, right: 35),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff808080),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        // Handle Google signup logic
                      },
                      icon: Image.asset("assets/google.png", height: 30),
                      label: Text(
                        'Sign Up with Google',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        key: _formKey,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        ),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPasswordField(
      String label, IconData icon, TextEditingController controller,bool pass_w) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        key: _formKey,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          suffixIcon: IconButton(
            icon: Icon(
              pass_w ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                pass_w = !pass_w;
              });
            },
          ),
        ),
        obscureText: !_isPasswordVisible,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Or Sign Up With',
              style: TextStyle(fontFamily: "Montserrat")),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
