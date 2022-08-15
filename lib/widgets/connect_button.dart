import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';

import '../providers/connection_provider.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future connect() async {
      context.read<ConnectionProvider>().setLoading(true);
      var shell = Shell();

      var connectResponse =
          await shell.run('/usr/share/speedify/speedify_cli connect es');
      Map<String, dynamic> res = jsonDecode(connectResponse.outText);
      context.read<ConnectionProvider>().setCity(res['city']);
      context.read<ConnectionProvider>().setCountry(res['country']);
      context.read<ConnectionProvider>().setFriendlyName(res['friendlyName']);
      context.read<ConnectionProvider>().setLoading(false);
      context.read<ConnectionProvider>().setAuthenticated(true);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: context.watch<ConnectionProvider>().loading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: () => {connect()},
                  child: const Text('Conectar')),
            ),
    );
  }

  styleFrom(Map map) {}
}
