import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedQuotesScreen extends StatefulWidget {
  @override
  _SavedQuotesScreenState createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  List<String> savedQuotes = [];

  @override
  void initState() {
    super.initState();
    getSavedQuotes();
  }

  Future<void> getSavedQuotes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> quotes = preferences.getStringList('savedQuotes') ?? [];
    setState(() {
      savedQuotes = quotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Quotes'),
      ),
      body: ListView(
        children: savedQuotes
            .map((quote) => ListTile(
                  title: Text(quote),
                  subtitle: Text(quote.date.toString()),
                ))
            .toList(),
      ),
    );
  }
}
