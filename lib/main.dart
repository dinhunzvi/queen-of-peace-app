import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/providers/appointment_provider.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/providers/patient_provider.dart';
import 'package:queen_of_peace/providers/user_provider.dart';
import 'package:queen_of_peace/screens/Login.dart';
import 'package:queen_of_peace/screens/patients.dart';
import 'package:queen_of_peace/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( context ) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: ( context, authProvider, child ) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<UserProvider>(
                    create: ( context ) => UserProvider() ),
                ChangeNotifierProvider<PatientProvider>(
                    create: ( context ) => PatientProvider() ),
                ChangeNotifierProvider<AppointmentProvider>(
                    create: ( context ) => AppointmentProvider() )
              ],
            child: MaterialApp(
              title: 'Queen of Peace Maternity Clinic',
              routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return Home();
                  } else {
                    return Login();
                  }
                },
                '/login': (context) => Login(),
                '/patients': (content) => const Patients(),
                '/categories': (content) => const Categories(),
              },,
            ),
          );
        },
      ),
    )
  }
}

