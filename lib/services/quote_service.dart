// quote_service.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math'; // Import for Random
import 'package:flutter/services.dart';
import '../models/quote.dart';

class QuoteService {
  Future<List<Quote>> fetchQuotes() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/quotes/quotes_data.json',
      );

      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

      return jsonList
          .map(
            (json) => Quote(
              text: json['text'] as String,
              author: json['author'] as String?,
              category: json['category'] as String,
              source: json['source'] as String?,
            ),
          )
          .toList();
    } catch (e) {
      print("Error fetching quotes from JSON: $e"); // Added error logging
      return [];
    }
  }

  Future<Quote?> getRandomQuote() async {
    List<Quote> quotes = await fetchQuotes();
    if (quotes.isEmpty) {
      print("No quotes available to pick from."); // Added logging for empty list
      return null; // Return null if no quotes are available
    }
    final random = Random();
    int randomIndex = random.nextInt(quotes.length);
    return quotes[randomIndex];
  }
}