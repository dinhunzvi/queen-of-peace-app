import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import '../providers/AuthProvider.dart';

class Register extends StatefulWidget {
  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String errorMessage = '';
  late String deviceName;

  @override
  void initState() {
    super.initState();

    getDeviceName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 8,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() {
                              errorMessage = '';
                            }),
                            decoration: InputDecoration(labelText: 'Name'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter email address';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() {
                              errorMessage = '';
                            }),
                            decoration:
                                InputDecoration(labelText: 'Email address'),
                          ),
                          TextFormField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter password';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() {
                              errorMessage = '';
                            }),
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                          TextFormField(
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: passwordConfirmController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Confirm password';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() {
                              errorMessage = '';
                            }),
                            decoration:
                                InputDecoration(labelText: 'Confirm password'),
                          ),
                          ElevatedButton(
                            onPressed: () => submit(),
                            child: const Text('Register'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 36)),
                          ),
                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, '/login');
                                },
                                child: const Text(
                                    'Already registered? Login here!'),
                              ))
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);

    try {
      await provider.register(
          nameController.text,
          emailController.text,
          passwordController.text,
          passwordConfirmController.text,
          deviceName);

      Navigator.pop(context);

      //return token;
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if ( Platform.isAndroid ) {
        var build = await deviceInfoPlugin.androidInfo;

        setState(() {
          deviceName = build.model;
        });
      } else if ( Platform.isIOS ) {
        var build = await deviceInfoPlugin.iosInfo;

        setState(() {
          deviceName = build.model;
        });
      }
    } on PlatformException {
      setState(() {
        deviceName = 'Failed to get platform version';
      });
    }

  }

}
