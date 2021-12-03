import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/services/database.dart';
import 'package:flutter/cupertino.dart';

class CurrentGroup extends ChangeNotifier {
  MyGroup? _currentGroup;
  Book? _currentBook;

  MyGroup? get getCurrentGroup => _currentGroup;
  Book? get getCurrentBook => _currentBook;

  // These should be a stream, this is not the best/most effecient way of doing it
  void updateStateFromDatabase(String? groupId) async {
    print("update top called");
    try {
      // get group info from firebase
      // get the current book info from firebase
      _currentGroup = await MyDatabase().getGroupInfo(groupId!);
      _currentBook = await MyDatabase().getCurrentBook(groupId, _currentGroup!.currentBookId!);
      notifyListeners();
      print("updateState called");
    } catch (e) {
      print("An error occured while updating the state from the database. Error: $e");
    }
  }
}
