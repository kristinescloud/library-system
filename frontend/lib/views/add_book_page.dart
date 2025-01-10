import 'package:flutter/material.dart';
import 'package:library_system_frontend/models/book.dart';
import 'package:library_system_frontend/views/book_details_page.dart';
import 'package:library_system_frontend/controllers/book_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _authorController = TextEditingController();
  final _titleController = TextEditingController();
  final _datePublishedController = TextEditingController();
  final _numberOfCopiesController = TextEditingController();
  final _isbnController = TextEditingController();
  final _categoryController = TextEditingController();
  final _genreController = TextEditingController();
  final _languageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formatController = TextEditingController();
  final _publisherController = TextEditingController();
  final _bookCoverController = TextEditingController();

  bool _isManualEntry = true;

  void _toggleEntryMode(bool isManual) {
    setState(() {
      _isManualEntry = isManual;
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final book = Book(
        author: _authorController.text,
        title: _titleController.text,
        publicationDate: _datePublishedController.text,
        quantity: _numberOfCopiesController.text,
        isbn: _isbnController.text,
        category: _categoryController.text,
        genre: _genreController.text,
        description: _descriptionController.text, 
        language: _languageController.text,
        format: _formatController.text,
        publisher: _publisherController.text,
        bookCover: _bookCoverController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(book: book, withConfirm: true,),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              autofocus: true,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(4294957782)),
              ),
              child: Text(
                'cancel', 
                style: TextStyle(
                  color: Color(4290386458),
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtons(
              isSelected: [_isManualEntry, !_isManualEntry],
              onPressed: (index) {
                _toggleEntryMode(index == 0);
              },
              borderRadius: BorderRadius.all(Radius.circular(16)),
              constraints: BoxConstraints(minHeight: 32.0, minWidth: 175.0),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Manual Entry'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('ISBN Search'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All required fields are *starred and must be filled to submit the form.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      TextFormField(
                        controller: _authorController,
                        decoration: InputDecoration(labelText: 'Author*'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the author';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title*'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _datePublishedController,
                        decoration: InputDecoration(labelText: 'Date Published*'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date published';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _numberOfCopiesController,
                        decoration: InputDecoration(labelText: 'Number of Copies*'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of copies';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _isbnController,
                        decoration: InputDecoration(labelText: 'ISBN*'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the ISBN';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(labelText: 'Category'),
                      ),
                      TextFormField(
                        controller: _genreController,
                        decoration: InputDecoration(labelText: 'Genre'),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                      TextFormField(
                        controller: _languageController,
                        decoration: InputDecoration(labelText: 'Language'),
                      ),
                      TextFormField(
                        controller: _formatController,
                        decoration: InputDecoration(labelText: 'Format'),
                      ),
                      TextFormField(
                        controller: _publisherController,
                        decoration: InputDecoration(labelText: 'Publisher'),
                      ),
                      TextFormField(
                        controller: _bookCoverController,
                        decoration: InputDecoration(labelText: 'Book Cover (URL)'),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FilledButton(
                          onPressed: _submitForm,
                          child: Text(
                            'submit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}