import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class QuoteData {
  final String id;
  final String quote;
  String? date;
  QuoteData({required this.id, required this.quote, required this.date});
  static QuoteData getPlaceholder() {
    return QuoteData(
      id: '',
      quote: '',
      date: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'date': date,
    };
  }

  factory QuoteData.fromJson(Map<String, dynamic> json) {
    return QuoteData(
      id: json['id'],
      quote: json['quote'],
      date: json['date'],
    );
  }
}

// Future<void> clearSharedPreferences() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.remove('quotes');
// }

Future<void> addQuote(QuoteData quote) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<QuoteData> quotes = await getSavedQuotes();
  quotes.add(QuoteData(
      id: quote.id,
      quote: quote.quote,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
  List<String> quoteJsonList =
      quotes.map((q) => jsonEncode(q.toJson())).toList();
  await prefs.setStringList('quotes', quoteJsonList);
}

// Future<void> addQuote(QuoteData quote) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<QuoteData> quotes = await getSavedQuotes();
//   quotes.add(QuoteData(
//       id: quote.id,
//       quote: quote.quote,
//       date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
//   List<String> quoteJsonList =
//       quotes.map((q) => jsonEncode(q.toJson())).toList();
//   await prefs.setStringList('quotes', quoteJsonList);
// }

// Future<List<QuoteData>> getSavedQuotes() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();

//   String? quotesJsonString = preferences.getString('quotes');
//   if (quotesJsonString == null || quotesJsonString.isEmpty) {
//     return [];
//   }

//   List<dynamic> quotesJson = jsonDecode(quotesJsonString);
//   List<QuoteData> savedQuotes = quotesJson
//       .map(
//         (quoteJson) => QuoteData.fromJson(quoteJson),
//       )
//       .toList();

//   return savedQuotes;
// }
Future<List<QuoteData>> getSavedQuotes() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  List<String>? quotesJson = preferences.getStringList('quotes');
  if (quotesJson == null || quotesJson.isEmpty) {
    return [];
  }

  List<QuoteData> savedQuotes = quotesJson
      .map(
        (quoteJson) => QuoteData.fromJson(jsonDecode(quoteJson)),
      )
      .toList();

  return savedQuotes;
}

Future<void> removeQuoteFromSharedPreferences(String quoteId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  List<QuoteData> quoteList = await getSavedQuotes();

  // Remove the quote
  quoteList.removeWhere((quote) => quote.id == quoteId);

  // Save the updated quotes to SharedPreferences
  List<String> quotesJsonList =
      quoteList.map((quote) => jsonEncode(quote.toJson())).toList();
  await sharedPreferences.setStringList('quotes', quotesJsonList);
}
