import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/register_model.dart';

class UserRegisterViewModel extends ChangeNotifier {
  UserRegister userRegister = UserRegister(
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
    gender: "1",
    birthdate: DateTime.now(),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setName(String name) {
    userRegister.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    userRegister.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    userRegister.password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    userRegister.confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setBirthdate(String birthdate) {
    userRegister.birthdate = DateTime.parse(birthdate);
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
    if (userRegister.password != userRegister.confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userRegister.email,
        password: userRegister.password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': userRegister.name,
        'email': userRegister.email,
        'birthdate': userRegister.birthdate.toIso8601String(),
        'gender': userRegister.gender,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado correctamente. Por favor, verifica tu correo electrónico.')),
      );

      // Navigate or perform additional actions
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Error al registrar el usuario')),
      );
    }
  }
}
