import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class QuoteData {
  final String quote;
  final String date;

  QuoteData({required this.quote, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'date': date,
    };
  }

  factory QuoteData.fromJson(Map<String, dynamic> json) {
    return QuoteData(
      quote: json['quote'],
      date: json['date'],
    );
  }
}

// Future<void> clearSharedPreferences() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.remove('quotes');
// }

Future<void> addQuote(String quote) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<QuoteData> quotes = await getSavedQuotes();
  quotes.add(QuoteData(
      quote: quote, date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
  List<Map<String, dynamic>> quoteJsonList =
      quotes.map((q) => q.toJson()).toList();
  await prefs.setString('quotes', jsonEncode(quoteJsonList));
}

Future<List<QuoteData>> getSavedQuotes() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String? quotesJson = preferences.getString('quotes');
  if (quotesJson == null || quotesJson.isEmpty) {
    return [];
  }

  List<dynamic> quotesList = jsonDecode(quotesJson);
  List<QuoteData> savedQuotes = quotesList
      .map(
        (quote) => QuoteData.fromJson(quote),
      )
      .toList();

  return savedQuotes;
}
