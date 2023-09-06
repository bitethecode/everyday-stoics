import 'package:flutter/material.dart';
import 'package:lit_starfield/lit_starfield.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'saved_quotes.dart';
import 'quotes_func.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

typedef TapCallback = void Function();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];
  bool isItemsLoaded = false;
  QuoteData currentQuote = QuoteData.getPlaceholder();
  int currentQuoteIndex = 0;

  Future<void> readItems() async {
    final String res = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(res);
    List<dynamic> quotesData = data["quotes"];
    List<QuoteData> quotes =
        quotesData.map((quote) => QuoteData.fromJson(quote)).toList();
    setState(() {
      _items = quotes;
      isItemsLoaded = true;
      currentQuote = _items[currentQuoteIndex];
    });
  }

  void changeText() {
    setState(() {
      currentQuote = _items[randomNumber()];
    });
  }

  int randomNumber() {
    return Random().nextInt(10);
  }

  void shareContent(String text) {
    Share.share(text);
  }

  // void clearSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }

  @override
  void initState() {
    super.initState();
    // clearSharedPreferences();
    readItems();
  }

  void tapShare() {
    String content = "Check out this amazing content!";
    shareContent(content);
  }

  void tapLike() async {
    addQuote(currentQuote);
  }

  Column _buildButtonColumn(
      Color color, IconData icon, String label, TapCallback tapCallback) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            tapCallback();
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        )
      ],
    );
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
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 50.0),
                    child: Text(
                      currentQuote.quote,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonColumn(
                        Colors.grey, Icons.share, 'share', tapShare),
                    _buildButtonColumn(
                        Colors.grey, Icons.favorite_border, 'like', tapLike)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SavedQuotesScreen()),
                        );
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: changeText,
          tooltip: 'New Quote',
          child: const Icon(Icons.refresh),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
