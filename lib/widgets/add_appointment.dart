import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/models/patient.dart';
import 'package:queen_of_peace/providers/patient_provider.dart';

class AddAppointment extends StatefulWidget {
  final Function appointmentCallback;

  const AddAppointment(this.appointmentCallback, {super.key});

  @override
  State<AddAppointment> createState() => _AddAppointment();
}

class _AddAppointment extends State<AddAppointment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = '';
  final patientController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final bpReadingController = TextEditingController();
  final temperatureController = TextEditingController();
  final sugarLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildPatientsDropDown(),
              TextFormField(
                controller: appointmentDateController,
                onTap: () {
                  selectDate(context);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Appointment date'),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Transaction date is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              TextFormField(
                controller: bpReadingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^-?(\d+\.?\d{0,2})?')),
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Blood Pressure',
                  hintText: '0',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Blood pressure is required';
                  }

                  final newValue = double.tryParse(value);

                  if (newValue == null) {
                    return 'Invalid number format';
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              TextFormField(
                controller: temperatureController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^-?(\d+\.?\d{0,2})?')),
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Temperature',
                  hintText: '36',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Temperature is required';
                  }

                  final newValue = double.tryParse(value);

                  if (newValue == null) {
                    return 'Invalid number format';
                  }
                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              TextFormField(
                controller: sugarLevelController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^-?(\d+\.?\d{0,2})?')),
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Blood sugar level',
                    hintText: '0',
                    icon: Icon(Icons.money)),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Blood sugar level is required';
                  }

                  final newValue = double.tryParse(value);

                  if (newValue == null) {
                    return 'Invalid number format';
                  }
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => addAppointment(context),
                      child: const Text('Save')),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Cancel'),
                  )
                ],
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              )
            ],
          )),
    );
  }

  Widget buildPatientsDropDown() {
    return Consumer<PatientProvider>(builder: (context, pProvider, child) {
      List<Patient> patients = pProvider.patients;

      return DropdownButtonFormField(
        elevation: 8,
        items: patients.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem(
              value: e.id.toString(),
              child: Text(
                e.name,
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue == null) {
            return;
          }

          setState(() {
            patientController.text = newValue.toString();
          });
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Patient'),
        dropdownColor: Colors.white,
        validator: (value) {
          if (value == null) {
            return 'Please select patient';
          }

          return null;
        },
      );
    });
  }

  Future addAppointment(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.appointmentCallback(
        int.parse(patientController.text),
        appointmentDateController.text,
        int.parse(bpReadingController.text),
        double.parse(temperatureController.text),
        double.parse(sugarLevelController.text));

    Navigator.pop(context);
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (picked != null) {
      setState(() {
        appointmentDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
