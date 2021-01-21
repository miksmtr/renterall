import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renterall/models/interfaces/operator.dart';
import 'dart:convert';

class FireStoreHelper {
  FirebaseFirestore firestore;

  CollectionReference collectionReference;
  FireStoreHelper(String collection) {
    firestore = FirebaseFirestore.instance;
    collectionReference = firestore.collection(collection);
  }
  Future<List<Operator>> getAllData() async {
    // Get docs from collection referencex,
    List<Operator> operatorList = new List<Operator>();
    Operator operatorVal;
    String android;
    String ios;
    OperatorSub operatorSub;
    OperatorDomain operatorDomain;
    final QuerySnapshot result = await collectionReference.get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((data) {
      data.data().forEach((k, v) {
        operatorVal = null;

        ios = null;
        android = null;
        operatorDomain = null;
        if (v != null) {
          v.forEach((key, val) {
            if (key == 'domain') {
              if (v['domain'] != null) {
                ios = v['domain']['ios'];
                android = v['domain']['android'];
                operatorDomain = OperatorDomain.fromJson(
                  v['domain'],
                );
              }
            }
          });
        }
        operatorSub = null;
        operatorSub = new OperatorSub(
          name: k.toString(),
          token: v['token'],
          domain: operatorDomain,
          type: data.id.toString(),
        );
        operatorVal =
            new Operator(name: k.toString(), operatorSub: operatorSub);

        operatorList.add(operatorVal);
      });
    });

    return operatorList;
    // Get data from docs and convert map to List
  }
}
