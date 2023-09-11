import 'package:flutter/material.dart';

import 'themes.dart';
import 'saved_quotes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void showThemes() {
    // Implement your logic to change the theme here
    // You can use a state management solution like Provider or Riverpod
    // to manage and update the theme throughout your app
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeSelectionScreen(),
      ),
    );
  }

  void showSavedQuotes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SavedQuotesScreen(),
      ),
    );
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
            onTap: () {
              showThemes();
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Saved Quotes'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showSavedQuotes();
            },
          )
        ]));
  }
}
