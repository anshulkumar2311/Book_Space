import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Databasehelp{
  late FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestorage{
    if(_firebaseFirestore == null){
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }
  Future<void> CreateNewRecord(String uid) async{
    await firestorage.collection("Book_donation").doc(uid).set({
    });
  }
}