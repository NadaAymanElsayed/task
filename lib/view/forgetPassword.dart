import 'package:flutter/material.dart';
import 'package:task2/view/login.dart';

import '../core/utils/validation.dart';
import 'home.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  @override
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isFormValid = false;
  bool _obscurePassword = true;

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscure = false,
  }) {
    String? error = validator(controller.text);
    bool isValid = error == null && controller.text.isNotEmpty;

    return TextFormField(
      controller: controller,
      obscureText: obscure ? _obscurePassword : false,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: obscure
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : (controller.text.isEmpty
            ? null
            : isValid
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.error, color: Colors.red)),
        errorText: controller.text.isEmpty ? null : error,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isValid ? Colors.green : Colors.red),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
      body: Container(
    color: Colors.white,
    child: Padding(
    padding: const EdgeInsets.all(24),
    child: Form(
      key: _formKey,
      onChanged: _validateForm,
      child: ListView(
      children: [
      SizedBox(height: 20),
      Container(
      padding:
      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
      "Forget password",
      style:
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "Enter your email for the verification process.\n"
                "We will send 4 digits code to your email.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        SizedBox(height: 30,),
        _buildTextField(
          label: "Email",
          controller: _emailController,
          validator: Validators.validateEmail,
        ),
        SizedBox(height: 50,),
        ElevatedButton(
          onPressed: isFormValid ? () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFormValid ? Colors.black : Colors.grey.shade300,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ],
      ),
    ),
    )
    )
    );
  }
}
