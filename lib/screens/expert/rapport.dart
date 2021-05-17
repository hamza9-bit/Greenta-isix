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
      child: Text(widget.parcelle),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.grey))),
    );
  }

  Widget _buildsinistre() {
    return Container(
      child: Text(widget.sinistre),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.grey))),
    );
  }

  Widget _buildDate() {
    return Container(
      child: Text(
          DateFormat('yyyy-MM-dd  kk:mm:ss').format(DateTime.now()).toString()),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.grey))),
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
        title: Text("    Rapport d'expertise"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
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
                height: 20,
              ),
              _buildparcelle(),
              SizedBox(
                height: 20,
              ),
              _buildsinistre(),
              SizedBox(
                height: 20,
              ),
              _buildDate(),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    label: file != null
                        ? Text("1 file selected")
                        : Text("no file selected"),
                    heroTag: "HEROTAG",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        child: Icon(Icons.upload_outlined),
                        onPressed: () async => openFileExplorer()),
                  )
                ],
              ),
              SizedBox(height: 25),
              ElevatedButton(
                child: Text(
                  'Envoyer',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () async {
                  if (file == null) {
                    toast.Fluttertoast.showToast(
                        msg: "ajouter un fichier d'abord",
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
                            msg: "rapport envoyé avec succes",
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green.withOpacity(0.8),
                            gravity: toast.ToastGravity.TOP);
                      } else {
                        toast.Fluttertoast.showToast(
                            msg: "an error was occured!",
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
                  image: NetworkImage(
                      "https://img-19.ccm2.net/byNncjU419IZarl3PQuTL5dUOq0=/170x/768dc2c5128d4b3ca0b28af6c3943a0c/ccm-faq/internship.png"),
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
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
