import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//Get Users Details
// Future<UserModel> getUserDetails() async {
//    User currentUser = _auth.currentUser!;
//    DocumentSnapshot documentSnapshot =await firebaseFirestore.collection('users').doc(currentUser.uid).get();
//    return UserModel.fromSnap(documentSnapshot);
// }

  //Register Provider
  Future<String> signUpUser({
    required String email,
    required String pass,
    required String username,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty && pass.isNotEmpty && username.isNotEmpty) {
        // Check if email is already in use
        QuerySnapshot existingUser = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (existingUser.docs.isNotEmpty) {
          throw Exception('Email is already in use');
        }

        // Create user account
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'firstName': username,

          'isVerify': false, // Default for non-whistleblowers
        });

        res = 'success';
      } else {
        res = 'All fields are required';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = 'Email is already in use';
      } else {
        res = e.message ?? 'An error occurred';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //For Provider Sign In
  Future<Map<String, dynamic>?> loginUpUser({
    required String email,
    required String pass,
  }) async {
    String res = 'Wrong Email or Password';
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        // Authenticate user
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );

        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        } else {
          throw Exception("User data not found");
        }
      } else {
        throw Exception("Email and password cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found';
      } else if (e.code == 'wrong-password') {
        res = 'Invalid password';
      }
      throw Exception(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
