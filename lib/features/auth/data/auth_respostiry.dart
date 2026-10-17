import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../../core/service/hive_constants.dart';

class AuthRespostiry {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Box sessionBox = Hive.box(HiveConstants.sessionBox);

  register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
  }) async {
    final userCredentials = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uId = userCredentials.user!.uid;

    await firestore.collection("users").doc(uId).set({
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phone': phone,
      'uId': uId,
    });

    sessionBox.put(HiveConstants.userBox, uId);
  }

  login({required String email, required String password}) async {
    final userCredentials = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    sessionBox.put(HiveConstants.userBox, userCredentials.user!.uid);
  }

  logout() async {
    await auth.signOut();
    sessionBox.clear();
  }

  Future<bool> isLoggedIn() async =>
      sessionBox.containsKey(HiveConstants.userBox);
}
