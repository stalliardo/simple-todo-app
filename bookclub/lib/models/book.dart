import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? id;
  String? name;
  String? author;
  int? length;
  Timestamp? completedDate;

  Book({
    this.id,
    required this.name,
    required this.length,
    required this.author,
    this.completedDate,
  });
}
