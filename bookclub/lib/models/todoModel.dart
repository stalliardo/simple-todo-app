import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String value;
  String id;
  String category;

  TodoModel({required this.value, required this.id, required this.category});

//   TodoModel.fromFirebase({required DocumentSnapshot doc}) {
// //       Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;

//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     print("constructor called ${data['value']}");

//     this.id = doc.id;
//     this.value = data["value"];
//   }

//   TodoModel.fromFirebase({required QuerySnapshot doc}) {
// //       Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;

//     // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     print(doc);

//     // print("constructor called ${data['value']}");

//     // this.id = doc.id;
//     // this.value = data["value"];
//   }
// }
}
