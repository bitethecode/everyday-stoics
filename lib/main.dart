import 'package:flutter/material.dart';
import 'package:lit_starfield/lit_starfield.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  List _items = [];
  bool isItemsLoaded = false;

  Future<void> readItems() async {
    final String res = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(res);
    setState(() {
      _items = data["quotes"];
      isItemsLoaded = true;
    });
  }

  String text = 'Hello World';

  void changeText() {
    setState(() {
      text = 'This is me!';
    });
  }

  int randomNumber() {
    return Random().nextInt(10);
  }

  @override
  void initState() {
    super.initState();
    readItems();
  }

  @override
  Widget build(BuildContext context) {
    if (isItemsLoaded) {
return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          const LitStarfieldContainer(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0), 
              child: Text(
                _items[randomNumber()], 
                style: TextStyle(
                  color: Colors.grey[500], 
                  fontSize: 24, 
                ),
              ),
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeText,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
    } 
    return Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    
  }
}
