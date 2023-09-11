import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';
import 'package:lit_starfield/lit_starfield.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'settings.dart';
import 'quotes_func.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeNotifier(), child: const MyApp()),
  );
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

  @override
  void initState() {
    super.initState();
    readItems();
  }

  void tapShare() {
    shareContent(currentQuote.quote);
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
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(
                  height: 8), // Add some spacing between the icon and label
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isItemsLoaded) {
      return Scaffold(
        appBar: null,
        body: Stack(
          children: <Widget>[
            Builder(
              builder: (BuildContext context) {
                final theme = Provider.of<ThemeNotifier>(context).selectedTheme;
                return LitStarfieldContainer(
                    backgroundDecoration:
                        BoxDecoration(color: theme.primaryColor));
              },
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 50.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${currentQuote.quote}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "- ${currentQuote.author}",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonColumn(Colors.grey, Icons.settings, 'settings',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    }),
                    _buildButtonColumn(
                        Colors.grey, Icons.share, 'share', tapShare),
                    _buildButtonColumn(
                        Colors.grey, Icons.favorite_border, 'like', tapLike),
                    _buildButtonColumn(Colors.grey, Icons.refresh, 'refresh',
                        () {
                      changeText();
                    })
                  ],
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            )
          ],
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
