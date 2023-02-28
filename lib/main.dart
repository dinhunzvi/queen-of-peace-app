import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/providers/appointment_provider.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/providers/patient_provider.dart';
import 'package:queen_of_peace/providers/user_provider.dart';
import 'package:queen_of_peace/screens/appointments.dart';
import 'package:queen_of_peace/screens/login.dart';
import 'package:queen_of_peace/screens/patients.dart';
import 'package:queen_of_peace/screens/home.dart';
import 'package:queen_of_peace/screens/register.dart';
import 'package:queen_of_peace/screens/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                  create: (context) => UserProvider()),
              ChangeNotifierProvider<PatientProvider>(
                  create: (context) => PatientProvider()),
              ChangeNotifierProvider<AppointmentProvider>(
                  create: (context) => AppointmentProvider())
            ],
            child: MaterialApp(
              title: 'Queen of Peace Maternity Clinic',
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return Home();
                  } else {
                    return const Login();
                  }
                },
                '/login': (context) => const Login(),
                '/users': (context) => Users(),
                '/patients': (content) => Patients(),
                '/appointments': (content) => Appointments(),
                '/register': (content) => const Register()
              },
            ),
          );
        },
      ),
    );
  }
}
