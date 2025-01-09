import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:developer';

import 'package:library_system_frontend/views/widgets/book_list_item.dart';
import 'package:library_system_frontend/views/book_details_page.dart';
import 'package:library_system_frontend/controllers/home_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchCriteria = 'title';
  List<dynamic>? _books;
  bool _isLoading = false;

  void getAllBooks() async {
    final homeController = HomeController(ref);
    setState(() {
          _isLoading = true;
    });
    try {
      final books = await homeController.fetchAllBooks();// Fetch all books initially;
      setState(() {
        _books = books;
      });
    } catch (error) {
      log('Error fetching books: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching books: $error')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void findBooks(critera, String keyword) async {
    final homeController = HomeController(ref);
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await homeController.searchBooks(criteria: critera, keyword: keyword);
      setState(() {
        _books = books;
      });
    } catch (error) {
      log('Error finding books: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading books')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllBooks();
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
                      getAllBooks();
                    } else {
                      findBooks(_searchCriteria, keyword);
                    }
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => getAllBooks(), // Fetch all books
            child: Text('show all books'),
          ),
          if (_books != null) 
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _books == null || _books!.isEmpty
                    ? Center(child: Text('No books available'))
                    : ListView.builder(
                        itemCount: _books?.length,
                        itemBuilder: (context, index) {
                          final book = _books?[index];
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