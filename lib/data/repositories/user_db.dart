import 'package:cloud_firestore/cloud_firestore.dart';

class UserDb {
  String userId;

  UserDb({required this.userId});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  // Adds data to database
  Future updateUserData(
      {String username = "",
      required String emailId,
      required String displayName,
      int noOfPeopleLikedUser = 0,
      String about = "",
      String gender = "",
      String phoneNo = "",
      String dob = ""}) async {
    List<String> trimmedEmail = [];
    trimmedEmail = emailId.split('@');
    trimmedEmail = trimmedEmail[0].split('+');
    print("save emaild id to firestore : $emailId");
    userCollection.doc(userId).set({
      'username': username == "" ? trimmedEmail[0] : username,
      'displayName': displayName,
      'noOfPeopleLikedUser': noOfPeopleLikedUser,
      'emailId': emailId,
      'gender': gender,
      'dob': dob,
      'phoneNo': phoneNo,
      'about': about,
    });
  }

  // Get datas from database
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
