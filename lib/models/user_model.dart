import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String password;
  String firstName;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.firstName,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'uid': uid,
        'email': email,
        'password': password,
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return UserModel(
      firstName: snapshot['firstName'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      password: snapshot['password'],
    );
  }
}
