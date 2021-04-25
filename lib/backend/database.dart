import 'dart:io';

import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/Risque.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/sinistre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> userSetup(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();

    profileList.add({'name': displayName, 'uid': uid});
    return;
  }

 /* Future<void> createUserData(String name, String email, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
    });
  }*/


    Future<bool> addUserToDB(Myuser myuser)async{
      
      return await profileList.doc(myuser.id).set(
        myuser.toMap(myuser)
      ).then((value) => true).onError((error, stackTrace) => false);

    } 


Stream<QuerySnapshot> getNoAcceptedUsers(){
  return profileList.where("accepted",isEqualTo: false).snapshots();
}

Stream<QuerySnapshot> getAgriculteurs(){
  return profileList.where("accepted",isEqualTo: true).where("role",isEqualTo: 0).snapshots();
}
Stream<QuerySnapshot> getExperts(){
  return profileList.where("accepted",isEqualTo: true).where("role",isEqualTo: 2).snapshots();
}

Stream<DocumentSnapshot> getUserStream(String uid){
  return profileList.doc(uid).snapshots();
}

Stream getagriParcelles(String uid){
  return profileList.doc(uid).collection("Parclles").snapshots();
}

Future<DocumentSnapshot>  getUserFuture(String uid)async{
  return await profileList.doc(uid).get().then((value) => value).onError((error, stackTrace) => null);
}
Future<bool> setAcceptedT(String uid)async{
  try{
    await profileList.doc(uid).update({"accepted":true});
    return true;
  }catch(e){
    return false;
  }
}

Future<bool> isUserexit(String uid)async{

      return (await profileList.doc(uid).get()).data()!=null;
  
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
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

  Future<bool> addMarkersToDb(Mymarker mymarker) async {
    try {
      await savesCollection.doc("markers").set(mymarker.toMap(mymarker));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }



  Future<DocumentSnapshot> getSavedMarkers()async{
    return await savesCollection.doc("markers").get();
  }

  Future<bool> addParcelleToDB(MyPpolygon myPpolygon) async {
    try {
      
      final DocumentReference documentReference = 
      profileList
      .doc(AuthenticationService().getCurrentUser().uid)
      .collection("Parcelles")
      .doc();

      myPpolygon.id=documentReference.id;
      
      final Map<String, dynamic> map = myPpolygon.toMap(myPpolygon) ;
      
      await documentReference.set(map);

      await parcelleCollection.doc(myPpolygon.id).set(map);

      return true;
    
    } catch (e) {
      print(e);
      return false;
    }
  }


Future<bool> setRef(String refName,String id,String uid)async{
  try{

    await profileList
      .doc(uid)
      .collection("Parcelles")
      .doc(id).update({"ref":refName});

    await parcelleCollection.doc(id).delete();

      return true;

  }catch(e){
    return false;
  }
}


Stream<QuerySnapshot> getSavedParcelles(String uid) {
    return profileList.doc(uid).collection("Parcelles").snapshots();
  }


Future<bool> makeExpertCansee(String id,String uid)async{
  return await sinistresCollec.doc(id).update({"whocansee":uid}).then((value) => true).onError((error, stackTrace) => false);
}

Future<DocumentSnapshot> getRisqueByuid(String uid)async{

return await profileList.doc(uid).collection("Risque").doc("infos").get();

}


  Stream<QuerySnapshot> getSinistres() {
    return sinistresCollec.snapshots();
  }
  
  Stream<QuerySnapshot> getSinistresWFilters(String uid) {
    return sinistresCollec.where("agriID",isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot> getSinistresWFiltersForExpert(String uid) {
    return sinistresCollec.where("whocansee",isEqualTo: uid).snapshots();
  }


  Stream<QuerySnapshot> getrapports(){
    return sinistresCollec.where("check",isEqualTo: true).snapshots();
  }
  
  Future<bool> deleteSinistre(String id)async{
    return await sinistresCollec.doc(id).delete().then((value) => true).onError((error, stackTrace) => false);
  }

Stream<QuerySnapshot> getAffectedParcelle(String uid){
  return profileList.doc(uid).collection("Parcelles").where("ref",isNotEqualTo: null).snapshots();
}

  Future<bool> addRisqueToDb(String uid,Risque risque)async{

  return await profileList.doc(uid)
    .collection("Risque")
    .doc("infos")
    .set(risque.toMap(risque))
    .then((value) async{
      await profileList.doc(uid).update({"risque":true});
      return true;
    })
    .onError((error, stackTrace) => false);

  }

Future<List<String>> uploadImageToDB(Map<String,String> map) async {

    final List<String> myList=<String>[];

  print(map);

   await Future.forEach(map.keys, (element)async{
        
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Images').child(element+element.hashCode.toString());

     await ref.putFile(File(map[element])).then((tasksnAP)async{
        myList.add(await tasksnAP.ref.getDownloadURL()); 
     }
     );

    });

  if (map.length!=myList.length){
    return null;
  }

  return myList;

}

Future<String> uploadFileToDb(String path) async {



final String filename=path.split("/").last;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Files').child(filename+filename.hashCode.toString());

    return await ref.putFile(File(path)).then((tasksnAP)async{
        return (await tasksnAP.ref.getDownloadURL()); 
     }
     ).onError((error, stackTrace) => null);

    }

Future<bool> sendRapport(String sinID,String date,String path)async{


return await uploadFileToDb(path).then((value)async{
        if (value!=null){
         return await sinistresCollec.doc(sinID).update({"check":true,"date":date,"filePath":value+"@${path.split("/")[1].split(".")[1]}"}).then((value) => true).onError((error, stackTrace) => false);
        }
        return false;
  }).onError((error, stackTrace) => false);


}

Future<bool> isUserAlreadyExcist(String cin)async{

return (await profileList.where("cin",isEqualTo: cin).get().onError((error, stackTrace) => null)).docs.length==1;

  }



  Future<bool> addSinistreToDb(Mysinistre sinistre,Map<String,String> map,int oldsin)async{
  

     return await uploadImageToDB(map).then((value)async{
        if (value!=null){
          sinistre.imagesUrl=value;
        }else{
          return false;
        }
        final ref = sinistresCollec.doc();
        sinistre.sinisteid=ref.id;
        await ref.set(sinistre.toMap(sinistre));
        await profileList.doc(sinistre.agriId).update(({"nbSinistre":oldsin+1}));
        return true;
      }).onError((error, stackTrace) => false);

  }


Stream<QuerySnapshot> getNoAffectedParcelle(){

return parcelleCollection.snapshots();

}



}
