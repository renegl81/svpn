import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svpn/pages/home_page.dart';
import 'package:svpn/providers/connection_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ConnectionProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future setWindowsSize() async {
    await DesktopWindow.setMaxWindowSize(const Size(500, 600));
    await DesktopWindow.setMinWindowSize(const Size(300, 500));
  }

  @override
  void initState() {
    setWindowsSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speedify UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Speedify UI'),
    );
  }
}
