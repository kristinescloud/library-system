import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'book_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchCriteria = 'title';
  List<dynamic> _books = [];
  bool _isLoading = false;

  Future<void> fetchBooks({String? criteria, String? keyword}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/books'),
      );

      if (response.statusCode == 200) {
        // Parse JSON response
        setState(() {
          _books = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      log('Error fetching books: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading books')),
      );

    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> findBooks({String? criteria, String? keyword}) async {
  setState(() {
    _isLoading = true;
  });

  try {
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
      setState(() {
        _books = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load books');
    }
  } catch (error) {
    print('Error finding books: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error loading books')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch all books initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('libro')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _searchCriteria,
                  items: <String>['title', 'author', 'genre', 'ISBN']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _searchCriteria = newValue!;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter keyword',
                      border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0))
                          ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String keyword = _searchController.text.trim();
                    if (keyword.isEmpty) {
                      fetchBooks(); // Show all books
                    } else {
                      findBooks(criteria: _searchCriteria, keyword: keyword);
                    }
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: fetchBooks, // Fetch all books
            child: Text('Show All Books'),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _books.isEmpty
                    ? Center(child: Text('No books available'))
                    : ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          return BookListItem(
                            book: book,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailsPage(book: book),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  final Map<String, dynamic> book;
  final VoidCallback onTap;

  const BookListItem({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.grey[300], // Placeholder for book cover image
          child: Icon(Icons.book, color: Colors.grey[700]),
        ),
        title: Text(book['title']),
        subtitle: Text('Author: ${book['author']}\nQuantity: ${book['quantity']}'),
        onTap: onTap,
      ),
    );
  }
}
