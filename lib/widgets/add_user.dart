import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  final Function userCallback;

  const AddUser( this.userCallback, {super.key});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final userEmailController = TextEditingController();
  final userNameController = TextEditingController();

  String errorMessage = '';

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
                      onPressed: () => addUser(context),
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

  Future addUser( context ) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await widget.userCallback(
      userNameController.text ,userEmailController.text
    );

    Navigator.pop(context);
  }
}