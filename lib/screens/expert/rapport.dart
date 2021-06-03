import 'package:CTAMA/backend/database.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Rapportexpertise extends StatefulWidget {
  final String parcelle;
  final String sinistre;
  final String cin;
  const Rapportexpertise({Key key, this.parcelle, this.sinistre, this.cin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RapportexpertiseState();
  }
}

class RapportexpertiseState extends State<Rapportexpertise> {
  Widget _buildparcelle() {
    return Container(
      child: Text(
        widget.parcelle,
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.blue[900],
          border: Border.fromBorderSide(BorderSide(color: Colors.black))),
    );
  }

  Widget _buildsinistre() {
    return Container(
      child: Text(widget.sinistre,
          style: TextStyle(color: Colors.white, fontSize: 17)),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.blue[900],
          border: Border.fromBorderSide(BorderSide(color: Colors.black))),
    );
  }

  Widget _buildDate() {
    return Container(
      child: Text(
          DateFormat('yyyy-MM-dd  kk:mm:ss').format(DateTime.now()).toString(),
          style: TextStyle(color: Colors.white, fontSize: 17)),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.blue[900],
          border: Border.fromBorderSide(BorderSide(color: Colors.black))),
    );
  }

  File file;

  void openFileExplorer() async {
    perm.Permission.storage.request().then((value) async {
      if (value == perm.PermissionStatus.granted) {
        file = null;
        try {
          file = (await FilePicker.getFile());
          setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: Text(" Rapport d'expertise"),
        backgroundColor: Colors.orange[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getHeader(),
              SizedBox(
                height: 30,
              ),
              _buildparcelle(),
              SizedBox(
                height: 30,
              ),
              _buildsinistre(),
              SizedBox(
                height: 30,
              ),
              _buildDate(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: Colors.blue[900],
                    label: file != null
                        ? Text("1 fichier sélectionné")
                        : Text("Aucun fichier sélectionné"),
                    heroTag: "HEROTAG",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.red[900],
                        child: Icon(Icons.upload_outlined),
                        onPressed: () async => openFileExplorer()),
                  )
                ],
              ),
              SizedBox(height: 25),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    minimumSize: Size(5, 45)),
                child: Text(
                  'Envoyer',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () async {
                  if (file == null) {
                    toast.Fluttertoast.showToast(
                        msg: "Ajouter un fichier D'abord",
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red.withOpacity(0.8),
                        gravity: toast.ToastGravity.TOP);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (cntx) => LoadScreen(
                                  cin: widget.cin,
                                  date: DateTime.now().toString(),
                                  path: file.path,
                                  sinistreID: widget.sinistre.split("°")[1],
                                ))).then((value) {
                      if (value) {
                        toast.Fluttertoast.showToast(
                            msg: "Rapport envoyé avec succés",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/rapport.png"),
                )),
          ),
        )
      ],
    );
  }
}

class LoadScreen extends StatelessWidget {
  const LoadScreen({
    Key key,
    this.sinistreID,
    this.path,
    this.date,
    this.cin,
  }) : super(key: key);

  final String sinistreID;
  final String path;
  final String date;
  final String cin;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: FutureBuilder(
          future:
              DatabaseService().sendRapport(sinistreID, date + "@" + cin, path),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(true);
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(false);
                });
              }
            }
            return Center(
              child: SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
