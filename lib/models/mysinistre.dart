import 'package:flutter/material.dart';

class Mysinistre {
  
  dynamic agriId;
  dynamic parcelleID;
  dynamic sinisteid;
  dynamic parcelleRef;
  dynamic imagesUrl;
  dynamic whocansee;
  dynamic date;
  dynamic filePath;
  dynamic isChecked;

  Mysinistre({
    this.agriId, 
    this.whocansee,
    this.parcelleID, 
    this.sinisteid, 
    this.imagesUrl,
    this.parcelleRef,
    this.isChecked,
    });

    Mysinistre.checked({
    this.agriId, 
    this.whocansee,
    this.parcelleID, 
    this.sinisteid, 
    this.imagesUrl,
    this.parcelleRef,
    this.date,
    this.filePath,
    this.isChecked,
    });

  Map<String, dynamic> toMap(Mysinistre mysinistre) {

    Map<String, dynamic> map = Map<String, dynamic>();

    map["ref"]=mysinistre.parcelleRef;
    map["agriID"] = mysinistre.agriId;
    map["parcelleID"] = mysinistre.parcelleID;
    map["sinistreID"] = mysinistre.sinisteid;
    map["images"] = mysinistre.imagesUrl;
    map["whocansee"] = mysinistre.whocansee;
    map["check"] = mysinistre.isChecked;
    return map;

  }
  Map<String, dynamic> toCheckedMap(Mysinistre mysinistre) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["ref"]=mysinistre.parcelleRef;
    map["agriID"] = mysinistre.agriId;
    map["parcelleID"] = mysinistre.parcelleID;
    map["sinistreID"] = mysinistre.sinisteid;
    map["images"] = mysinistre.imagesUrl;
    map["whocansee"] = mysinistre.whocansee;
    map["date"] = mysinistre.date;
    map["filePath"] = mysinistre.filePath;
    map["check"] = mysinistre.isChecked;
    return map;

  }

  Mysinistre.fromMap(Map<String, dynamic> map) {

    this.sinisteid = map["sinistreID"];
    this.parcelleID = map["parcelleID"];
    this.imagesUrl = map["images"];
    this.agriId = map["agriID"];
    this.parcelleRef = map["ref"];
    this.whocansee = map["whocansee"];
    this.isChecked = map["check"];
  }


    Mysinistre.fromCheckedMap(Map<String, dynamic> map) {

    this.sinisteid = map["sinistreID"];
    this.parcelleID = map["parcelleID"];
    this.imagesUrl = map["images"];
    this.agriId = map["agriID"];
    this.parcelleRef = map["ref"];
    this.filePath=map["filePath"];
    this.date = map["date"];
    this.whocansee = map["whocansee"];
    this.isChecked = map["check"];

  }
}
