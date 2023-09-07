import 'package:flutter/material.dart';

class ColorSchemePreview extends StatelessWidget {
  final List<Color> colors;

  const ColorSchemePreview({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];

        return Container(
          height: 100,
          color: color,
          child: Center(
            child: Text(
              'Color ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
