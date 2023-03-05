import 'package:flutter/cupertino.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/services/api.dart';

import '../models/appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> appointments = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  AppointmentProvider(this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future<void> init() async {
    appointments = await apiService.fetchAppointments();

    notifyListeners();
  }

  Future<void> addAppointment(int patientId, String appointmentDate,
      int bpReading, double temperature, double sugarLevels) async {
    Appointment appointment = await apiService.addAppointment(
        patientId, bpReading, appointmentDate, temperature, sugarLevels);
    appointments.add(appointment);

    notifyListeners();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    Appointment updatedAppointment =
        await apiService.updateAppointment(appointment);
    int index = appointments.indexOf(appointment);
    appointments[index] = updatedAppointment;

    notifyListeners();
  }
}
