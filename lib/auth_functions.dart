import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makeathon/userModel.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sign up user
  Future<String> SignupUser({
    required String email,
    required String password,
    required String username,
    required String type,
    required String age,
    required String allergens,
    required String favDish,
  }) async {
    String res = "Some error occured";
    try {
      if (age.isEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          type.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //add user to our database
        List allergy = [allergens];
        List fav = [favDish];
        Map<String, dynamic> user = {
          'name': username,
          'uid': cred.user!.uid,
          'email': email,
          'age': age,
          'allergens': allergy,
          'favoriteDishes': fav,
        };

        await _firestore.collection('users').doc(cred.user!.uid).set(user);
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password should be of atlest 6 letters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Log in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured!';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please Enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
