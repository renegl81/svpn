import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svpn/providers/connection_provider.dart';

class ConnectionDetails extends StatelessWidget {
  const ConnectionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.watch<ConnectionProvider>().friendlyName.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      'Conectado a: ${context.watch<ConnectionProvider>().friendlyName}',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
