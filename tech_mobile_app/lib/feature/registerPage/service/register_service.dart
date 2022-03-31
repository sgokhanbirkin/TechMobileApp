import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String? name,
    required String? email,
    required String? password,
    required String? phone,
    required String? dob,
    required bool? isTeacher,
  }) async {
    try {
      UserCredential? userCredential;
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      print('Kayıt başarılı');
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'dob': dob,
        'isTeacher': isTeacher,
        'uid': userCredential.user!.uid,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Email already in use');
      } else if (e.code == 'weak-password') {
        throw Exception('Weak password');
      }
    } catch (e) {
      print('KAYIT TAMAMLANMADIIIII');
      rethrow;
    }
  }
}
