import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:queen_of_peace/screens/appointments.dart';
import 'package:queen_of_peace/screens/patients.dart';

import '../providers/auth_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetOptions = [Patients(), Appointments()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queen of Peace Maternity Clinic',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                label: 'Patients',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Log Out',
              )
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  Future<void> onItemTapped(int index) async {
    if (index == 2) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);

      await authProvider.logout();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
}
