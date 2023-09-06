import 'package:flutter/material.dart';
import 'quotes_func.dart';

class SavedQuotesScreen extends StatefulWidget {
  const SavedQuotesScreen({Key? key}) : super(key: key);

  @override
  _SavedQuotesScreenState createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  List<QuoteData> savedQuotes = [];

  @override
  void initState() {
    super.initState();
    setSavedQuotes();
  }

  Future<void> setSavedQuotes() async {
    List<QuoteData> quotes = await getSavedQuotes();
    setState(() {
      savedQuotes = quotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Quotes'),
        ),
        body: ListView(
          children: savedQuotes.map((quoteData) {
            return Dismissible(
              key: Key(quoteData.id),
              onDismissed: (direction) {
                removeQuoteFromSharedPreferences(quoteData.id);
                // Remove the quote from your data source
                setState(() {
                  savedQuotes.remove(quoteData);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[
                      200], // Change this to your desired background color
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: ListTile(
                  title: Text(quoteData.quote),
                  subtitle: Text(quoteData.date.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Show a confirmation dialog if needed

                      removeQuoteFromSharedPreferences(quoteData.id);
                      setState(() {
                        savedQuotes
                            .removeWhere((item) => item.id == quoteData.id);
                      });
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
