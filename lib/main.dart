import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

void main() => runApp(const MyApp(color: Colors.blue));

@pragma('vm:entry-point')
void topMain() => runApp(const MyApp(color: Colors.green));

@pragma('vm:entry-point')
void bottomMain() => runApp(const MyApp(color: Colors.purple));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.color});

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: color,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
  }

  void startGame(String token) {
    _channel.invokeMethod<void>("startGame", token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => startGame("abc"),
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}