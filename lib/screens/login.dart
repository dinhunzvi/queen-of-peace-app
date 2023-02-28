import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = '';
  late String deviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                  elevation: 8,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
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
                          ElevatedButton(
                            onPressed: () => submit(),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 36)),
                            child: const Text('Login'),
                          ),
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, '/register');
                                },
                                child:
                                    const Text('Not registered? Register here'),
                              ))
                        ],
                      ),
                    ),
                  ))
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
      await provider.login(emailController.text, passwordController.text);

      // return token;
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }
}
