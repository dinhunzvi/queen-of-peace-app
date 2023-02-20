import 'package:flutter/material.dart';

import '../models/user.dart';

class EditUser extends StatefulWidget {
  final Function userCallback;
  final User user;

  const EditUser( this.userCallback, this.user, {super.key});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final userEmailController = TextEditingController();
  final userNameController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    userNameController.text = widget.user.name.toString();
    userEmailController.text = widget.user.email.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only( top: 50, left: 10, right: 10 ),
      child: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
                controller: userNameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter name';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              TextFormField(
                onChanged: (text) => setState(() {
                  errorMessage = '';
                }),
                controller: userEmailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter email address';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email address'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => updateUser(context),
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

  Future updateUser( context ) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.user.email = userEmailController.text;
    widget.user.name = userNameController.text;

    await widget.userCallback( widget.user );

    Navigator.pop(context);
  }
}