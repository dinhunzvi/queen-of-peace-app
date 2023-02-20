class Appointment {
  int id;
  int patientId;
  String appointmentDate;
  String bpReading;
  String temperature;
  String sugarLevel;

  Appointment(
      {required this.id,
      required this.patientId,
      required this.appointmentDate,
      required this.bpReading,
      required this.temperature,
      required this.sugarLevel});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        patientId: json['patientId'],
        appointmentDate: json['appointmentDate'],
        bpReading: json['bpReading'],
        temperature: json['temperature'],
        sugarLevel: json['sugarLevel']);
  }
}
