import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/connection_provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/connection_details.dart';
import '../widgets/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future login(String email, String password) async {
    var shell = Shell();

    var loginResponse = await shell
        .run('/usr/share/speedify/speedify_cli login $email $password');

    Map<String, dynamic> res = jsonDecode(loginResponse.outText);
    if (res['state'] == 'LOGGED_IN') {
      context.read<ConnectionProvider>().setAuthenticated(true);
    }
  }

  Future<void> getCredentials() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (prefs.getString('email') != null &&
          prefs.getString('password') != null) {
        var email = prefs.getString('email');
        var password = prefs.getString('password');
        login(email as String, password!);
        context.read<ConnectionProvider>().setAuthenticated(true);
      }
    });
  }

  @override
  void initState() {
    getCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo.png',
          width: 300,
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: context.watch<ConnectionProvider>().authenticated
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    ConnectionDetails(),
                    ActionButtons()
                  ],
                )
              : const Login(),
        ),
      ),
    );
  }
}
