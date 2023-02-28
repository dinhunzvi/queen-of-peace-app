import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/models/patient.dart';
import 'package:queen_of_peace/providers/patient_provider.dart';
import 'package:queen_of_peace/widgets/add_patient.dart';
import 'package:queen_of_peace/widgets/edit_patient.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    List<Patient> patients = provider.patients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      body: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            Patient patient = patients[index];
            return ListTile(
              title: Text(patient.name),
              subtitle: Text(patient.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(patient.dob)],
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return EditPatient(
                                  patient, provider.updatePatient);
                            });
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(onPressed: null, icon: const Icon(Icons.delete))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddPatient(provider.addPatient);
                });
          }),
    );
  }
}
