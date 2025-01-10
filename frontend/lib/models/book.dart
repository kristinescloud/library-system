class Book {
  final String author;
  final String title;
  final String publicationDate;
  final String quantity;
  final String isbn;
  final String? category;
  final String? genre;
  final String? description;
  final String? language;
  final String? format;
  final String? publisher;
  final String? bookCover;

  Book({
    required this.author,
    required this.title,
    required this.publicationDate,
    required this.quantity,
    required this.isbn,
    this.category,
    this.genre,
    this.description,
    this.language,
    this.format,
    this.publisher,
    this.bookCover,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'publicationDate': publicationDate,
      'quantity': quantity,
      'isbn': isbn,
      'category': category,
      'genre': genre,
      'description': description,
      'language': language,
      'format': format,
      'publisher': publisher,
      'bookCover': bookCover,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      author: json['author'],
      title: json['title'],
      publicationDate: json['publicationDate'],
      quantity: json['quantity'],
      isbn: json['isbn'],
      category: json['category'],
      genre: json['genre'],
      description: json['description'],
      language: json['language'],
      format: json['format'],
      publisher: json['publisher'],
      bookCover: json['bookCover'],
    );
  }
}