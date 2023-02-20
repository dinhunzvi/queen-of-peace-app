class Patient {
  int id;
  String name;
  String email;
  String address;
  String dob;

  Patient(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.dob});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        dob: json['dob']);
  }
}
