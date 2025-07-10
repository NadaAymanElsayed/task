import 'package:flutter/material.dart';
import 'package:task2/constants/Assets.dart';
import 'package:task2/view/login.dart';
import '../core/utils/validation.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      "Create an account",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "Let's create your account.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 24),
                  _buildTextField(
                    label: "Full Name",
                    controller: _nameController,
                    validator: Validators.validateName,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: "Email",
                    controller: _emailController,
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: "Password",
                    controller: _passwordController,
                    validator: Validators.validatePassword,
                    obscure: true,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isFormValid ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFormValid ? Colors.black : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Create an Account",
                    style: TextStyle(color: Colors.white),),
                  ),

                  SizedBox(height: 16),
                  Center(child: Text("Or")),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.iconGg,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Sign Up with Google",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF1877F2),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.iconFB,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Sign Up with Facebook",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
                    }, child: Text("Login",
                    style: TextStyle(
                      color: Colors.black
                    ),))
                  ],
                )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

