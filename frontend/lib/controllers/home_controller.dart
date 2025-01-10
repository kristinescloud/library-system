// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:library_system_frontend/models/book.dart';
// import 'dart:developer';

// import 'package:library_system_frontend/views/widgets/book_list_item.dart';
// import 'package:library_system_frontend/views/book_details_page.dart';

class HomeController {
  final WidgetRef ref;

  HomeController(this.ref);

  Future<List<Book>?> fetchAllBooks({String? criteria, String? keyword}) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/books'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>?> searchBooks({String? criteria, String? keyword}) async {
    String query;
    if (criteria != null && keyword != null && keyword.isNotEmpty) {
      if (criteria == 'ISBN') {
        query = '/$keyword';
      } else {
        query = '/search?params=$criteria:$keyword';
      }
    } else {
      query = '';
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/books$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }



  }

}