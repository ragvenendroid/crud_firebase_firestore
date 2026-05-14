import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _phoneNum = TextEditingController();
  final _address = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _obscure = true;

  // void _register() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() => _loading = true);
  //
  //   final error = await AuthService()
  //       .register(_nameCtrl.text, _emailCtrl.text, _passCtrl.text);
  //
  //   setState(() => _loading = false);
  //   if (error != null && mounted) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(error)));
  //   }
  //   // On success, StreamBuilder in main.dart navigates to TaskScreen automatically
  // }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final error = await AuthService()
        .register(_nameCtrl.text, _emailCtrl.text, _passCtrl.text);

    setState(() => _loading = false);

    if (!mounted) return;

    if (error != null) {
      // ❌ Error snack_bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(error)),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      // ✅ Success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 10),
              Text('Welcome, ${_nameCtrl.text.trim()}! Account created 🎉'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_add_alt_1,
                      size: 72, color: Colors.indigo),

                  const SizedBox(height: 16),

                  //Get Started
                  Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 32),

                  // name
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter your name' : null,
                  ),

                  const SizedBox(height: 16),

                  // email
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                    v == null || !v.contains('@') ? 'Enter valid email' : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) =>
                    v == null || v.length < 6 ? 'Min 6 characters' : null,
                  ),

                  const SizedBox(height: 24),

                  // // phone no.
                  // TextFormField(
                  //   controller: _phoneNum,
                  //   keyboardType: TextInputType.phone,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Phone Number',
                  //     prefixIcon: Icon(Icons.call),
                  //     border: OutlineInputBorder(),
                  //   ),
                  //
                  //   validator: (v) {
                  //     if (v == null || v.trim().isEmpty) {
                  //       return 'Enter your phone no.';
                  //     }
                  //
                  //     if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                  //       return 'Enter valid 10 digit phone number';
                  //     }
                  //
                  //     return null;
                  //   },
                  //
                  // ),
                  //
                  // const SizedBox(height: 24),
                  //
                  // // address
                  // TextFormField(
                  //   controller: _address,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Address',
                  //     prefixIcon: Icon(Icons.home),
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: (v) =>
                  //   v == null || v.trim().isEmpty ? 'Enter your address' : null,
                  // ),

                  // const SizedBox(height: 24),

                  // Register button
                  FilledButton(
                    onPressed: _loading ? null : _register,
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: _loading
                        ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                        : const Text('Register', style: TextStyle(fontSize: 16)),
                  ),

                  const SizedBox(height: 16),

                  // Already have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),

                      //Login button small
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}