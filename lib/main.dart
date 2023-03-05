import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/providers/appointment_provider.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/providers/patient_provider.dart';
import 'package:queen_of_peace/providers/user_provider.dart';
import 'package:queen_of_peace/screens/appointments.dart';
import 'package:queen_of_peace/screens/auth/login.dart';
import 'package:queen_of_peace/screens/patients.dart';
import 'package:queen_of_peace/screens/home.dart';
import 'package:queen_of_peace/screens/auth/register.dart';
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
                  create: (context) => UserProvider(authProvider)),
              ChangeNotifierProvider<PatientProvider>(
                  create: (context) => PatientProvider(authProvider)),
              ChangeNotifierProvider<AppointmentProvider>(
                  create: (context) => AppointmentProvider(authProvider))
            ],
            child: MaterialApp(
              title: 'Queen of Peace Maternity Clinic',
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return const Home();
                  } else {
                    return const Login();
                  }
                },
                '/login': (context) => const Login(),
                '/users': (context) => const Users(),
                '/patients': (content) => const Patients(),
                '/appointments': (content) => const Appointments(),
                '/register': (content) => const Register()
              },
            ),
          );
        },
      ),
    );
  }
}
