import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Myuser {
  String name;

  String email;

  bool risque;

  int role;

  String cin;

  bool accepted;

  String pass;

  String imageUrl;

  String id;

  int nbSinisitre;

  Myuser(
      {this.name,
      @required this.nbSinisitre,
      this.cin,
      this.email,
      this.accepted,
      this.imageUrl,
      this.pass,
      this.role,
      this.id,
      this.risque = false});

  Map<String, dynamic> toMap(Myuser myuser) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["nbSinistre"] = myuser.nbSinisitre;
    map["name"] = myuser.name;
    map["email"] = myuser.email;
    map["risque"] = myuser.risque;
    map["role"] = myuser.role;
    map["accepted"] = myuser.accepted;
    map["pass"] = myuser.pass;
    map["image"] = myuser.imageUrl;
    map["id"] = myuser.id;
    map["cin"] = myuser.cin;

    return map;
  }

  Map<String, dynamic> toNOAGRIMap(Myuser myuser) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["name"] = myuser.name;
    map["email"] = myuser.email;
    map["risque"] = myuser.risque;
    map["role"] = myuser.role;
    map["accepted"] = myuser.accepted;
    map["pass"] = myuser.pass;
    map["image"] = myuser.imageUrl;
    map["id"] = myuser.id;
    map["cin"] = myuser.cin;

    return map;
  }

  Myuser.fromMap(Map<String, dynamic> map) {
    this.nbSinisitre = map["nbSinistre"];
    this.risque = map["risque"];
    this.name = map["name"];
    this.email = map["email"];
    this.imageUrl = map["image"];
    this.pass = map["pass"];
    this.accepted = map["accepted"];
    this.id = map["id"];
    this.role = map["role"];
    this.cin = map["cin"];
  }
}
