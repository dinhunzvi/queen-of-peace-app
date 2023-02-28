import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                            decoration:
                                const InputDecoration(labelText: 'Name'),
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
                            decoration: const InputDecoration(
                                labelText: 'Email address'),
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
                            decoration:
                                const InputDecoration(labelText: 'Password'),
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
                            decoration: const InputDecoration(
                                labelText: 'Confirm password'),
                          ),
                          ElevatedButton(
                            onPressed: () => submit(),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 36)),
                            child: const Text('Register'),
                          ),
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).maybePop('/login');
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
      await provider.register(nameController.text, emailController.text,
          passwordController.text, passwordConfirmController.text);

      Navigator.pop(context);

      //return token;
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }
}
