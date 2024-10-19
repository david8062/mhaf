import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../positions/view/postions_view.dart';

class LoginVM extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _email = '';
  String _password = '';

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      
      if (userDoc.exists) {  
        String gender = userDoc.get('gender') ?? '';          
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PositionsView(gender: gender)),
        );
      } else {
        print("Usuario o Contraseña incorrectos");
      }
    } on FirebaseAuthException catch (e) {
      print("Login failed: ${e.message}");
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
