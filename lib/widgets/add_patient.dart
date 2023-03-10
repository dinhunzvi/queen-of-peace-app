import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPatient extends StatefulWidget {
  final Function patientCallback;

  const AddPatient(this.patientCallback, {Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final patientNameController = TextEditingController();
  final patientEmailController = TextEditingController();
  final patientDobController = TextEditingController();
  final patientAddressController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
                controller: patientNameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter patient name';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              TextFormField(
                controller: patientDobController,
                onTap: () {
                  selectDate(context);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Date of birth'),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Date of birth is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              TextFormField(
                controller: patientEmailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter email address';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
                decoration: const InputDecoration(labelText: 'Email address'),
              ),
              TextFormField(
                controller: patientAddressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Address is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => addPatient(context),
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

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1983),
        lastDate: DateTime(2005));

    if (picked != null) {
      setState(() {
        patientDobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future addPatient(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await widget.patientCallback(
        patientNameController.text,
        patientEmailController.text,
        patientAddressController.text,
        patientDobController.text);

    Navigator.pop(context);
  }
}
