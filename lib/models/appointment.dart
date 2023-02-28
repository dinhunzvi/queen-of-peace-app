class Appointment {
  int id;
  int? patientId;
  String appointmentDate;
  String patientName;
  int bpReading;
  double temperature;
  double sugarLevel;

  Appointment(
      {required this.id,
      required this.patientId,
      required this.appointmentDate,
      required this.patientName,
      required this.bpReading,
      required this.temperature,
      required this.sugarLevel});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        patientId: json['patient_id'],
        appointmentDate: json['appointment_date'],
        patientName: json['patient_name'],
        bpReading: json['bp_reading'],
        temperature: double.parse(json['temperature']),
        sugarLevel: double.parse(json['sugar_levels']));
  }
}
