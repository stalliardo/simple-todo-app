import 'package:bookclub/models/book.dart';
import 'package:bookclub/models/group.dart';
import 'package:bookclub/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum StatusCode { ERROR, SUCCESS }

class MyDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(MyUser user) async {
    String returnValue = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        "fullName": user.fullName,
        "email": user.email,
        "accountCreated": Timestamp.now(),
      });

      returnValue = "Success";
    } catch (e) {
      print(e);
    }

    return returnValue;
  }

  Future<MyUser> getUserInfo(String uid) async {
    MyUser user = MyUser();

    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(uid).get();

      Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;

      user.uid = uid;
      user.fullName = data["fullName"];
      user.email = data["email"];
      user.accountCreated = data["accountCreated"];
      user.groupId = data["groupId"];
    } catch (e) {
      print(e);
    }

    return user;
  }

  /////////////////////////////////////////////// Group operations ///////////////////////////////////////////////

  Future<StatusCode> createGroup(String groupName, String userUid, Book initialBook) async {
    // DocumentReference is used here to get the groupId so we can use it
    List<String>? members = [];
    try {
      members.add(userUid);

      DocumentReference docRef = await _firestore.collection("groups").add({
        "name": groupName,
        "leader": userUid,
        "members": members,
        "groupCreated": Timestamp.now(),
      });

      await _firestore.collection("users").doc(userUid).update({
        "groupId": docRef.id,
      });

      //TODO add book

      await addBook(docRef.id, initialBook);

      // trouble now is that the changes to the user state arent being observed/notified....
      // every call to the root page should reload the currentUser to refresh any state changes

      return StatusCode.SUCCESS;
    } catch (e) {
      return StatusCode.ERROR;
    }
  }

  Future<StatusCode> joinGroup(String groupId, String userUid) async {
    List<String> members = [userUid];

    try {
      await _firestore.collection("groups").doc(groupId).update({
        "members": FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").doc(userUid).update({
        "groupId": groupId,
      });
      return StatusCode.SUCCESS;
    } catch (e) {
      return StatusCode.ERROR;
    }
  }

  Future<MyGroup> getGroupInfo(String groupId) async {
    MyGroup? group;

    try {
      DocumentSnapshot _doc = await _firestore.collection("groups").doc(groupId).get();

      Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;

      group = MyGroup(
        id: groupId,
        name: data["name"],
        leader: data["leader"],
        members: List<String>.from(data["members"]),
        groupCreated: data["groupCreated"],
        currentBookId: data["currentBookId"], // This is null
        currentBookDueDate: data["currentBookDueDate"],
      );
      return group;
    } catch (e) {
      print(e);
    }

    return group!;
  }

  Future<StatusCode> addBook(String groupId, Book book) async {
    try {
      DocumentReference _docRef = await _firestore.collection("groups").doc(groupId).collection("books").add({
        // using add here to get a doc ref
        "name": book.name,
        "author": book.author,
        "length": book.length,
        "completedDate": book.completedDate,
      });

      // doc ref needed to add the current book to the group schedule

      await _firestore.collection("groups").doc(groupId).update({
        "currentBookId": _docRef.id,
        "currentBookDueDate": book.completedDate,
      });

      return StatusCode.SUCCESS;
    } catch (e) {
      print(e);
    }

    return StatusCode.ERROR;
  }

  Future<Book> getCurrentBook(String groupId, String bookId) async {
    Book? book;

    try {
      // Get the nested books collection from inside the groups collection
      DocumentSnapshot _doc = await _firestore.collection("groups").doc(groupId).collection("books").doc(bookId).get();

      Map<String, dynamic> data = _doc.data() as Map<String, dynamic>;

      book = Book(
        id: bookId,
        name: data["name"],
        length: data["length"],
        completedDate: data["completedDate"],
        author: data["author"],
      );
      return book;
    } catch (e) {
      print(e);
    }

    return book!;
  }
}
