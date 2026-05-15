import 'package:auth_crud_endroid/screens/update_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _obscure = true;

  void _showDeleteDialog() {
    final _passCtrl = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Delete Account', style: TextStyle(color: Colors.red)),
            ],
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This action is permanent and cannot be undone. All your tasks will be deleted.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter your password to confirm:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setDialogState(() => _obscure = !_obscure),
                  ),
                ),
              ),
            ],
          ),
          actions: [

            // Cancel button
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),

            // delete button
            FilledButton(
              onPressed: () async {
                if (_passCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Please enter your password'),
                        ],
                      ),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                  return;
                }

                Navigator.pop(ctx); // close dialog

                try {
                  final user = FirebaseAuth.instance.currentUser!;

                  // Re-authenticate first
                  final credential = EmailAuthProvider.credential(
                    email: user.email!,
                    password: _passCtrl.text.trim(),
                  );
                  await user.reauthenticateWithCredential(credential);


                  // Delete account
                  await user.delete();

                  if (!mounted) return;

                  // ✅ Success snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Account deleted successfully'),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  // Wait for snackbar to show then navigate to Login
                  // StreamBuilder in main.dart auto-navigates to LoginScreen
                  // await Future.delayed(const Duration(seconds: 2));
                  // if (!mounted) return;
                  // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  await Future.delayed(const Duration(seconds: 2));
                  if (!mounted) return;
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );


                } on FirebaseAuthException catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.white),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(e.message ?? 'Wrong password')),
                        ],
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo.shade100,
                child: Text(
                  (user.displayName ?? user.email ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                user.displayName ?? 'No Name',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                user.email ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 36),
              const Divider(),
              const SizedBox(height: 16),
              _infoTile(Icons.person_outline, 'Name', user.displayName ?? 'Not set'),
              const SizedBox(height: 12),
              _infoTile(Icons.email_outlined, 'Email', user.email ?? 'Not set'),

              const SizedBox(height: 12),

              _infoTile(
                Icons.verified_outlined,
                'Email Verified',
                user.emailVerified ? 'Yes ✅' : 'No ❌',
              ),
              const SizedBox(height: 20,),

              //update password
              FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UpdatePassword()),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Update Password', style: TextStyle(fontSize: 16)),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),

              const SizedBox(height: 12),

              //delete account
              FilledButton.icon(
                onPressed: _showDeleteDialog,  // ← calls the dialog
                icon: const Icon(Icons.delete),
                label: const Text('Delete Account', style: TextStyle(fontSize: 16)),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),

            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 22),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}