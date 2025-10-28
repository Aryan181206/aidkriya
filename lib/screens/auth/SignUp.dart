import 'package:aidkriya/colors/MyColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// Enum for signup role
enum SignupTab { wanderer, walker }

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // --- State ---
  SignupTab _selectedTab = SignupTab.wanderer;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // --- Controllers ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // --- Firebase Instances ---
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Custom textfield ---
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    String? helperText,
    required bool isVisible,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.useBlack,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword && !isVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            if (label == 'Password' && value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            if (label == 'Confirm Password' &&
                value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          style: const TextStyle(color: MyColors.useBlack),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: MyColors.hintColor),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            filled: true,
            fillColor: MyColors.textFieldFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: isPassword
                ? Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: onToggleVisibility,
                child: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: MyColors.hintColor,
                ),
              ),
            )
                : null,
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              helperText,
              style: const TextStyle(fontSize: 12, color: MyColors.hintColor),
            ),
          ),
      ],
    );
  }

  // --- Tab widget ---
  Widget _buildTab(String text, SignupTab tab) {
    bool isSelected = _selectedTab == tab;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = tab;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? MyColors.useBlack : MyColors.hintColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 70,
            decoration: BoxDecoration(
              color: isSelected ? MyColors.lightYellow : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  // --- Firebase Signup Logic ---
  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Create user in Firebase Auth
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCred.user;
      if (user != null) {
        // Determine role and collection
        String role =
        _selectedTab == SignupTab.wanderer ? 'wanderer' : 'walker';
        String collectionName = role == 'wanderer' ? 'wanderers' : 'walkers';

        // Save to Firestore
        await _firestore.collection(collectionName).doc(user.uid).set({
          'uid': user.uid,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully as $role!')),
        );

        if (role == 'wanderer') {
          Navigator.pushReplacementNamed(context, '/wanderermainscreen');
        } else {
          Navigator.pushReplacementNamed(context, '/walker');
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Signup failed';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.useWhite,
      appBar: AppBar(
        backgroundColor: MyColors.useWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.useBlack),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
        title: const Text(
          'Create Your Account',
          style: TextStyle(
            color: MyColors.useBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Role Tabs ---
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTab('Wanderer', SignupTab.wanderer),
                    _buildTab('Walker', SignupTab.walker),
                  ],
                ),
              ),

              _buildTextField(
                label: 'Name',
                hint: 'Enter your name',
                controller: _nameController,
                isVisible: true,
              ),
              const SizedBox(height: 25),

              _buildTextField(
                label: 'Email',
                hint: 'Your email address',
                controller: _emailController,
                isVisible: true,
              ),
              const SizedBox(height: 25),

              _buildTextField(
                label: 'Phone',
                hint: 'Your phone number',
                controller: _phoneController,
                isVisible: true,
              ),
              const SizedBox(height: 25),

              _buildTextField(
                label: 'Password',
                hint: 'Create a password',
                isPassword: true,
                helperText: 'Your password must be at least 8 characters long.',
                controller: _passwordController,
                isVisible: _isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 25),

              _buildTextField(
                label: 'Confirm Password',
                hint: 'Confirm your password',
                isPassword: true,
                controller: _confirmPasswordController,
                isVisible: _isConfirmPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 30),

              Center(
                child: "Already have an account? Login"
                    .text
                    .xl
                    .semiBold
                    .color(MyColors.useBlack)
                    .make()
                    .onTap(() => Navigator.pushReplacementNamed(context, '/login')),
              ),

              const SizedBox(height: 10),

              // --- Signup Button ---
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: MyColors.useBlack,
                  )
                      : const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.useBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
