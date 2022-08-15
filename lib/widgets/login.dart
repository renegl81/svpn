import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svpn/providers/connection_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  late String _errorMessage = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future login() async {
      _errorMessage = '';
      var shell = Shell();

      var loginResponse = await shell.run(
          '/usr/share/speedify/speedify_cli login ${email.text} ${password.text}');

      Map<String, dynamic> res = jsonDecode(loginResponse.outText);
      if (res['state'] == 'LOGGED_IN' || res['state'] == 'CONNECTED') {
        final SharedPreferences prefs = await _prefs;
        prefs.setString('email', email.text);
        prefs.setString('password', password.text);
        context.read<ConnectionProvider>().setAuthenticated(true);
      } else {
        _errorMessage = res['errorMessage'] as String;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _errorMessage.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : Container(),
            context.read<ConnectionProvider>().loading
                ? const CircularProgressIndicator()
                : Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 300,
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entre un email válido';
                        }
                        return null;
                      },
                    ),
                  ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: 300,
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entre un password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                    onPressed: () => {
                          if (_formKey.currentState!.validate()) {login()}
                        },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    child: const Text('Login')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
