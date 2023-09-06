import 'package:flutter/material.dart';
// import 'quotes_func.dart';

import 'saved_quotes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // List<QuoteData> savedQuotes = [];

  @override
  void initState() {
    super.initState();
    // setSavedQuotes();
  }

  // Future<void> setSavedQuotes() async {
  //   List<QuoteData> quotes = await getSavedQuotes();
  //   setState(() {
  //     savedQuotes = quotes;
  //   });
  // }

  void selectTheme(String theme) {
    // Implement your logic to change the theme here
    // You can use a state management solution like Provider or Riverpod
    // to manage and update the theme throughout your app
  }

  void showSavedQuotes() {
    // Implement the logic to show the saved quotes
    // You can navigate to a new screen or display a dialog
    // to show the saved quotes to the user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(children: [
          ListTile(
            title: const Text('Themes'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Saved Quotes'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedQuotesScreen(),
                ),
              );
            },
          )
        ]
            // children: savedQuotes.map((quoteData) {
            //   return Dismissible(
            //     key: Key(quoteData.id),
            //     onDismissed: (direction) {
            //       removeQuoteFromSharedPreferences(quoteData.id);
            //       // Remove the quote from your data source
            //       setState(() {
            //         savedQuotes.remove(quoteData);
            //       });
            //     },
            //     child: Container(
            //       margin: const EdgeInsets.all(4.0),
            //       decoration: BoxDecoration(
            //         color: Colors.grey[
            //             200], // Change this to your desired background color
            //         borderRadius: BorderRadius.circular(4.0),
            //       ),
            //       child: ListTile(
            //         title: Text(quoteData.quote),
            //         subtitle: Text(quoteData.date.toString()),
            //         trailing: IconButton(
            //           icon: const Icon(Icons.delete),
            //           onPressed: () {
            //             // Show a confirmation dialog if needed

            //             removeQuoteFromSharedPreferences(quoteData.id);
            //             setState(() {
            //               savedQuotes
            //                   .removeWhere((item) => item.id == quoteData.id);
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //   );
            // }).toList(),
            ));
  }
}
