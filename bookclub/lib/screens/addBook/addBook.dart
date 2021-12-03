import 'package:bookclub/models/book.dart';
import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  final bool? onGroupCreation;
  final String? groupName;

  AddBook({this.onGroupCreation, this.groupName});

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  void _addBook(BuildContext context, String groupName, Book book) async {
    print("Add book called");
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    StatusCode _statusCode;

    if (widget.onGroupCreation == true) {
      _statusCode = await MyDatabase().createGroup(groupName, _currentUser.getCurrentUser.uid!, book);
    } else {
      print("ELse called");
      _statusCode = await MyDatabase().addBook(_currentUser.getCurrentUser.groupId!, book);
    }

    if (_statusCode == StatusCode.SUCCESS) {
      // Passed to the root widget as that decides what screen/widget to display.
      print("Success called");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyRoot()), (route) => false);
    }
  }

  TextEditingController _booNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            MyContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _booNameController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group), hintText: "Book Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group), hintText: "Author"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group), hintText: "Length"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(_selectedDate),
                  ),
                  Text(DateFormat("H:mm").format(_selectedDate)),
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text("Change Date"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Book book = Book(
                        name: _booNameController.text,
                        length: int.parse(_lengthController.text),
                        author: _authorController.text,
                        completedDate: Timestamp.fromDate(_selectedDate),
                      );

                      print("on pressde called gruopName = ${widget.groupName}");
                      _addBook(context, widget.groupName!, book);
                    },
                    child: Text(
                      "Add Book",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
