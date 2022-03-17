import 'dart:io';

import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/Risque.dart';

import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference savesCollection =
      FirebaseFirestore.instance.collection('SAVES');
  final CollectionReference sinistresCollec =
      FirebaseFirestore.instance.collection('Sinistres');
  final CollectionReference parcelleCollection =
      FirebaseFirestore.instance.collection('NOAParcelles');

  /*Future<void> userSetup(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();

    profileList.add({'name': displayName, 'uid': uid});
    return;
  }*/

  /* Future<void> createUserData(String name, String email, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
    });
  }*/

  Future<bool> resetpass(String password, String uid) async {
    try {
      await profileList.doc(uid).update({"pass": password});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addUserToDB(Myuser myuser) async {
    return await profileList
        .doc(myuser.id)
        .set(!(myuser.role != 0)
            ? myuser.toMap(myuser)
            : myuser.toNOAGRIMap(myuser))
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot> getNoAcceptedUsers() {
    return profileList.where("accepted", isEqualTo: false).snapshots();
  }

  Stream<QuerySnapshot> getAgriculteurs() {
    return profileList
        .where("accepted", isEqualTo: true)
        .where("role", isEqualTo: 0)
        .snapshots();
  }

  Stream<DocumentSnapshot> getUserStream(String uid) {
    return profileList.doc(uid).snapshots();
  }

  Stream getagriParcelles(String uid) {
    return profileList.doc(uid).collection("Parclles").snapshots();
  }

  Future<DocumentSnapshot> getUserFuture(String uid) async {
    return await profileList
        .doc(uid)
        .get()
        .then((value) => value)
        .onError((error, stackTrace) => null);
  }

  Future<DocumentSnapshot> getparcelleFuture(String uid, String id) async {
    return await profileList
        .doc(uid)
        .collection("Parcelles")
        .doc(id)
        .get()
        .then((value) => value)
        .onError((error, stackTrace) => null);
  }

  Future<bool> deleteNOAparcelle(String uid) async {
    try {
      await DatabaseService().parcelleCollection.doc(uid).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAparcelle(String uid, String id) async {
    try {
      await profileList.doc(uid).collection("Parcelles").doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> setAcceptedT(String uid) async {
    try {
      await profileList.doc(uid).update({"accepted": true});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isUserexit(String uid) async {
    return (await profileList.doc(uid).get()).data() != null;
  }

  Future<bool> addUsersToDb(Myuser myuser) async {
    try {
      await profileList.doc().set(myuser.toMap(myuser));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addParcelleToDB(MyPpolygon myPpolygon) async {
    try {
      final DocumentReference documentReference = profileList
          .doc(AuthenticationService().getCurrentUser().uid)
          .collection("Parcelles")
          .doc();

      myPpolygon.id = documentReference.id;

      final Map<String, dynamic> map = myPpolygon.toMap(myPpolygon);

      await documentReference.set(map);

      await parcelleCollection.doc(myPpolygon.id).set(map);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getSavedParcelles(String uid) {
    return profileList.doc(uid).collection("Parcelles").snapshots();
  }

  Future<DocumentSnapshot> getRisqueByuid(String uid) async {
    return await profileList.doc(uid).collection("Risque").doc("infos").get();
  }

  Stream<QuerySnapshot> getAffectedParcelle(String uid) {
    return profileList
        .doc(uid)
        .collection("Parcelles")
        .where("ref", isNotEqualTo: "null")
        .snapshots();
  }

  Future<bool> addRisqueToDb(String uid, Risque risque) async {
    return await profileList
        .doc(uid)
        .collection("Risque")
        .doc("infos")
        .set(risque.toMap(risque))
        .then((value) async {
      await profileList.doc(uid).update({"risque": true});
      return true;
    }).onError((error, stackTrace) => false);
  }

  Future<bool> isUserAlreadyExist(String cin) async {
    return (await profileList
                .where("Tel", isEqualTo: cin)
                .get()
                .onError((error, stackTrace) => null))
            .docs
            .length ==
        1;
  }

  Stream<QuerySnapshot> getNoAffectedParcelle() {
    return parcelleCollection.snapshots();
  }
}
