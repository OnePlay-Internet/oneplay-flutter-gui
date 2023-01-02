import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';

void main() => runApp(const MyApp(color: Colors.blue));

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
  TextEditingController tokenCtrler = TextEditingController();

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
              onPressed: () => displayTextInputDialog(context),
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }

  void displayTextInputDialog(BuildContext context) async {
    tokenCtrler.text = await FlutterClipboard.paste();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please fill your token!'),
            content: TextField(
              controller: tokenCtrler,
              decoration: InputDecoration(
                  hintText: "Your token",
                  suffixIcon: InkWell(
                    onTap: () {
                      tokenCtrler.clear();
                    },
                    child: const Icon(Icons.close_rounded),
                  )),
            ),
            actions: [
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  startGame(tokenCtrler.text);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
