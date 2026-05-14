import 'package:flutter/material.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            const SizedBox(height: 32),

            //Padding(padding: EdgeInsets.all(20)),

            TextFormField(

                //controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  //prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Enter your name' : null,

            ),

            const SizedBox(height: 32),

            TextFormField(

              //controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'New Password',
                //prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v == null || v.trim().isEmpty ? 'Enter your name' : null,

            ),

            const SizedBox(height: 32),

            TextFormField(

              //controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                //prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v == null || v.trim().isEmpty ? 'Enter your name' : null,

            ),

            const SizedBox(height: 32),

            // Logout button
            FilledButton.icon(
              onPressed: () {

              },
              icon: const Icon(Icons.airplane_ticket_outlined),
              label: const Text('Change Password', style: TextStyle(fontSize: 16)),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

          ],

        ),
      ),
    );
  }
}
