import 'package:aidkriya/colors/MyColors.dart';
import 'package:aidkriya/screens/auth/SignUp.dart';
import 'package:aidkriya/screens/wanderer_screen/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // --- Controllers ---
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- Form Key ---
  final _formKey = GlobalKey<FormState>();

  // --- Password Visibility State ---
  bool _isPasswordVisible = false;

  // --- Loading State ---
  bool _isLoading = false;

  // --- Firebase Auth Instance ---
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Login Logic ---
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );


       Navigator.pushReplacementNamed(context, '/wanMS');


    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      if (e.code == 'user-not-found') {
        message = 'No user found for this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.useYellow,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    color: MyColors.useWhite,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // --- Email Input ---
                      _buildTextField(
                        labelText: 'Email',
                        controller: _emailController,
                        isPassword: false,
                      ),
                      const SizedBox(height: 20),

                      // --- Password Input ---
                      _buildTextField(
                        labelText: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),
                       const SizedBox(height: 20),

                      // --- Login Button ---
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.useYellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                              : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // --- Sign Up Link ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'New here?',
                            style:
                            TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signup(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

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


  // --- Reusable Text Field ---
  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    required bool isPassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelText is required';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: labelText,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }

  // --- Social Login Icon ---
  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    bool isPlaceholder = false,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isPlaceholder ? color : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: isPlaceholder
            ? const SizedBox.shrink()
            : Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }
}
