import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes_preview.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

List<ThemeData> availableThemes = [
  ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    // Add more properties as per your requirements
  ),
  ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF283828),
    // Add more properties as per your requirements
  ),
  // Add more themes as neededselectTheme
];

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({Key? key}) : super(key: key);

  @override
  _ThemeSelectionScreenState createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  late ThemeData selectedTheme;

  @override
  void initState() {
    super.initState();
    // Set initial theme
    selectedTheme = availableThemes[0];
  }

  void changeTheme(ThemeData theme) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.selectedTheme = theme;

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Selection'),
      ),
      body: ListView.builder(
        itemCount: availableThemes.length,
        itemBuilder: (context, index) {
          final theme = availableThemes[index];
          return Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text('Theme ${index + 1}'),
                    onTap: () {
                      changeTheme(theme);
                    },
                    trailing: SizedBox(
                      width: 80,
                      child: ColorSchemePreview(
                          colors: [theme.primaryColor, theme.backgroundColor]),
                    ),
                  )));
        },
      ),
    );
  }
}
