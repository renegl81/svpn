import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';
import 'package:svpn/providers/connection_provider.dart';

class DisconnectButton extends StatelessWidget {
  const DisconnectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future disconnect() async {
      var shell = Shell();

      var disconnectResponse =
          await shell.run('/usr/share/speedify/speedify_cli disconnect');
      Map<String, dynamic> res = jsonDecode(disconnectResponse.outText);
      context.read<ConnectionProvider>().resetState();
    }

    return context.watch<ConnectionProvider>().authenticated
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      primary: Colors.red),
                  onPressed: () => {disconnect()},
                  child: const Text('Salir')),
            ),
          )
        : Container();
  }
}
