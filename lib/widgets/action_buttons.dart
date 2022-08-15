import 'package:flutter/material.dart';
import 'package:svpn/widgets/connect_button.dart';
import 'package:svpn/widgets/disconnect_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [ConnectButton(), DisconnectButton()],
          )
        ],
      ),
    );
  }
}
