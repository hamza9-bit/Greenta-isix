import 'dart:ui';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/widgets/background-image.dart';

import 'package:CTAMA/widgets/text-field-input.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sinistre extends StatefulWidget {
  final String name;
  final String uid;
  final int nbsin;

  const Sinistre({Key key, this.uid, this.name, this.nbsin}) : super(key: key);

  @override
  _SinistreState createState() => _SinistreState();
}

class _SinistreState extends State<Sinistre> {
  MyPpolygon myPpolygon;

  showImagesModal(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (cntx) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
            itemCount: _paths.length,
            itemBuilder: (cntx, index) {
              return Image.file(
                File(_paths.values.toList()[index]),
                fit: BoxFit.cover,
              );
            }),
        elevation: 10,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  Future<MyPpolygon> showParcellesModal(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (cntx) => ParcelleSelector(
              uid: widget.uid,
            ),
        elevation: 10,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true);
  }

  Map<String, String> _paths = Map<String, String>();

  void openFileExplorer() async {
    perm.Permission.storage.request().then((value) async {
      if (value == perm.PermissionStatus.granted) {
        _paths = Map<String, String>();
        try {
          _paths = (await FilePicker.getMultiFilePath(type: FileType.IMAGE));
          setState(() {});
          print(_paths);
        } on PlatformException catch (e) {
          print("Unsupported operation" + e.toString());
        }
        if (!mounted) return;
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: "assets/images/login_bg.png"),
        Scaffold(
          appBar: AppBar(
            title: Text("Sinistre"),
            backgroundColor: Colors.orange[900],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  Container(
                    height: 200,
                    child: Image(
                      image: AssetImage('assets/images/piw.png'),
                      width: 500,
                      height: 120,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 70,
                height: 70,
              ),
              Column(
                children: [
                  Container(
                    child: TextInputField(
                      initialValue: widget.name,
                      readonly: true,
                      icon: FontAwesomeIcons.user,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                          backgroundColor: Colors.blue[900],
                          label: _paths != null
                              ? Row(
                                  children: [
                                    Text("${_paths.length} image selectionée"),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Icon(Icons.arrow_forward_ios_outlined)
                                  ],
                                )
                              : Text("Importer Images"),
                          icon: _paths != null
                              ? SizedBox()
                              : Icon(Icons.upload_outlined),
                          heroTag: "HEROTAG",
                          onPressed: () async => _paths != null
                              ? showImagesModal(context)
                              : openFileExplorer()),
                      if (_paths != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                              backgroundColor: Colors.red[900],
                              child: Icon(Icons.upload_outlined),
                              onPressed: () async => openFileExplorer()),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .75,
                      child: GestureDetector(
                        onTap: () {
                          showParcellesModal(context).then((value) {
                            if (value != null) {
                              setState(() {
                                myPpolygon = value;
                              });
                            }
                          });
                        },
                        child: ListTile(
                          trailing: Icon(Icons.arrow_upward_outlined,
                              color: Colors.blue[900]),
                          title: myPpolygon != null
                              ? Text(
                                  "Parcelle N° ${myPpolygon.reference}",
                                  style: TextStyle(
                                          color: Colors.blue[900], fontSize: 17)
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Veuiller choisir la parcelle",
                                  style: TextStyle(color: Colors.blue[900])
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                    color: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () async {
                      if (myPpolygon == null) {
                        toast.Fluttertoast.showToast(
                            msg: "Choisir Une Parcelle Premierement!",
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red.withOpacity(0.8),
                            gravity: toast.ToastGravity.TOP);
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (cntx) => LoadScreen(
                                      nbsin: widget.nbsin,
                                      map: _paths,
                                      sinistre: Mysinistre(
                                        agriId: widget.uid,
                                        parcelleID: myPpolygon.id,
                                        parcelleRef: myPpolygon.reference,
                                      ),
                                    )))
                            .then((value) {
                          if (value) {
                            toast.Fluttertoast.showToast(
                                msg: "Sinistre envoyé avec succés",
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.green.withOpacity(0.8),
                                gravity: toast.ToastGravity.TOP);
                          } else {
                            toast.Fluttertoast.showToast(
                                msg: "Une erreur s'est produite!",
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                gravity: toast.ToastGravity.TOP);
                          }
                        });
                      }
                    },
                    child: Text('Envoyer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.1,
                          fontFamily: 'home',
                        ).copyWith(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          )),
        ),
      ],
    );
  }
}

class ParcelleSelector extends StatelessWidget {
  const ParcelleSelector({Key key, this.uid}) : super(key: key);

  final String uid;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      child: StreamBuilder(
        stream: DatabaseService().getAffectedParcelle(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelle ajouté.",
                    style: TextStyle(fontSize: 23)),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final MyPpolygon myPpolygon =
                      MyPpolygon.fromMap(snapshot.data.docs[index].data());
                  return GestureDetector(
                      onTap: () => Navigator.of(context).pop(myPpolygon),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Text("Parcelle n° ${myPpolygon.reference}",
                                style: TextStyle(fontSize: 25)),
                          ),
                        ),
                      ));
                },
              );
            }
          }
          return Center(
            child: SizedBox(),
          );
        },
      ),
    );
  }
}

class LoadScreen extends StatelessWidget {
  const LoadScreen({Key key, this.sinistre, this.map, this.nbsin})
      : super(key: key);

  final Mysinistre sinistre;
  final Map<String, String> map;
  final int nbsin;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: FutureBuilder(
          future: DatabaseService().addSinistreToDb(sinistre, map, nbsin),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                Navigator.of(context).pop(true);
              } else {
                Navigator.of(context).pop(false);
              }
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[900]),
                strokeWidth: 4,
              ),
            );
          },
        ),
      ),
    );
  }
}
