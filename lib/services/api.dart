import 'dart:convert';
import 'dart:io';

import 'package:queen_of_peace/models/appointment.dart';

import '../models/patient.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {

  ApiService();

  final String baseUrl = "192.168.1.1:8888/";

  Future<List<User>> fetchUsers() async {
    http.Response response = await http.get(
      Uri.parse( '${baseUrl}users' ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    List users = jsonDecode( response.body );
    
    return users.map((user) => User.fromJson( user) ).toList();

  }

  Future<User> addUser(String name, String email) async {
    http.Response response = await http.post(
      Uri.parse( '${baseUrl}users'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      
      body: jsonEncode({ 'name' : name, 'email' : email })
    );

    if (response.statusCode != 201) {
      throw Exception('Error happened on create');
    }

    return User.fromJson(jsonDecode(response.body));
    
  }

  Future<User> updateUser(User user) async {
    http.Response response = await http.put(
        Uri.parse( '${baseUrl}users/${user.id}' ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },

        body: jsonEncode({ 'name' : user.name, 'email' : user.email })
    );

    if (response.statusCode != 201) {
      throw Exception('Error happened on create');
    }

    return User.fromJson(jsonDecode(response.body));

  }

  Future<List<Patient>> fetchPatients() async {
    http.Response response = await http.get(
      Uri.parse( '${baseUrl}patients' ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      }
    );

    List patients = jsonDecode( response.body );

    return patients.map(( patient ) => Patient.fromJson( patient ) ).toList();

  }

  Future<Patient> addPatient( String name, String email, String address,
      String dob ) async {
    http.Response response = await http.post(
      Uri.parse( '${baseUrl}patients' ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
      body: jsonEncode({ 'name': name, 'email' :email, ''
          'address': address, 'dob': dob})
    );

    if ( response.statusCode != 201 ) {
      throw Exception( 'Error occurred saving the patient details' );
    }
    
    return Patient.fromJson( jsonDecode( response.body ) );

  }

  Future<Patient> updatePatient( Patient patient ) async {
    http.Response response = await http.put(
        Uri.parse( '${baseUrl}patients/${patient.id.toString()}' ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: jsonEncode({ 'name': patient.name, 'email': patient.email,
          'address': patient.address, 'dob': patient.dob})
    );

    if ( response.statusCode != 201 ) {
      throw Exception( 'Error occurred updating the patient details' );
    }

    return Patient.fromJson( jsonDecode( response.body ) );

  }

  Future<List<Appointment>> fetchAppointments() async {
    http.Response response = await http.get(
      Uri.parse( '${baseUrl}appointments' ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      }
    );

    List appointments = jsonDecode( response.body );

    return appointments.map((appointment) =>
        Appointment.fromJson( appointment)).toList();

  }

  Future<Appointment> addAppointment( int patientId, String bpReading,
      String appointmentDate, String temperature, String sugarLevel ) async {
    http.Response response = await http.post(
      Uri.parse( '${baseUrl}appointments' ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
      body: jsonEncode({ 'patient_id' : patientId, 'bp_reading' : bpReading,
        'appointment_date' : appointmentDate, 'temperature' : temperature,
        'sugar_levels': sugarLevel } )
    );

    if ( response.statusCode != 201 ) {
      throw Exception( 'Error saving appointment details');
    }

    return Appointment.fromJson( jsonDecode( response.body ) );

  }

  Future<Appointment> updateAppointment( Appointment appointment ) async {
    http.Response response = await http.put(
        Uri.parse( '${baseUrl}appointments/${appointment.id.toString()}' ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: jsonEncode({ 'patient_id' : appointment.patientId,
          'bp_reading' : appointment.bpReading,
          'appointment_date' : appointment.appointmentDate,
          'temperature' : appointment.temperature,
          'sugar_levels': appointment.sugarLevel } )
    );

    if ( response.statusCode != 201 ) {
      throw Exception( 'Error saving appointment details');
    }

    return Appointment.fromJson( jsonDecode( response.body ) );

  }


}