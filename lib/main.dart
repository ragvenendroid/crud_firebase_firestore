import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) return const TaskScreen();
            return const LoginScreen();
          },
        ),
      },
    );
    // return MaterialApp(
    //   title: 'Task Manager',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     colorSchemeSeed: Colors.indigo,
    //     useMaterial3: true,
    //   ),
    //   home: StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Scaffold(
    //           body: Center(child: CircularProgressIndicator()),
    //         );
    //       }
    //       if (snapshot.hasData) {
    //         return const TaskScreen();
    //       }
    //       return const LoginScreen();
    //     },
    //   ),
    // );
  }
}