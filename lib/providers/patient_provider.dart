import 'package:flutter/cupertino.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/services/api.dart';

import '../models/patient.dart';

class PatientProvider extends ChangeNotifier {
  List<Patient> patients = [];

  late ApiService apiService;

  late AuthProvider authProvider;

  PatientProvider(this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future<void> init() async {
    patients = await apiService.fetchPatients();

    notifyListeners();
  }

  Future<void> addPatient(
      String name, String email, String address, String dob) async {
    Patient patient = await apiService.addPatient(name, email, address, dob);
    patients.add(patient);

    notifyListeners();
  }

  Future<void> updatePatient(Patient patient) async {
    Patient updatedPatient = await apiService.updatePatient(patient);
    int index = patients.indexOf(patient);
    patients[index] = updatedPatient;

    notifyListeners();
  }

  Future<void> deletePatient(Patient patient) async {
    try {
      apiService.deletePatient(patient.id);
    } on Exception {
      throw Exception('Error deleting patient');
    }
  }
}
