import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

import '../polymaker/polymaker.dart';

class SavedParcelle extends StatelessWidget {
  final bool iamagri;

  SavedParcelle({Key key, this.uid, this.iamagri = false}) : super(key: key);

  Future<bool> createDialog(
    BuildContext context,
    String id,
  ) async {
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    final TextEditingController textEditingController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (cntx) {
        return new AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () async {
                try {
                  final bool exist = await DatabaseService()
                      .isrefAlreadyExist(textEditingController.text, uid);
                  print(exist);
                  if (exist != null) {
                    if (!exist) {
                      if (globalKey.currentState.validate()) {
                        return await DatabaseService()
                            .setRef(textEditingController.text, id, uid)
                            .then((value) {
                          Navigator.of(context).pop(value);
                        });
                      }
                    } else {
                      toast.Fluttertoast.showToast(
                          msg: "Réference existe déja",
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          gravity: toast.ToastGravity.TOP);
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Enregistrer"),
            )
          ],
          content: Container(
            child: Form(
              key: globalKey,
              child: TextFormField(
                controller: textEditingController,
                validator: (String str) {
                  if (str.isEmpty) {
                    return "Veuillez entrez une réference ";
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          title: Text("Entrer Réference : "),
        );
      },
    );
  }

  Future<bool> createDialog1(BuildContext context, String uid, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir supprimer cette parcelle?"),
            elevation: 10,
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Non"),
              ),
              MaterialButton(
                onPressed: () async {
                  await DatabaseService().deleteNOAparcelle(id);
                  await DatabaseService().deleteAparcelle(uid, id);

                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Oui",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        });
  }

  final String uid;
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: iamagri
          ? FloatingActionButton(
              onPressed: () =>
                  getLocation(context, enableDragMarker: true, myuser: null),
              child: Icon(Icons.add),
            )
          : SizedBox(),
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text(" PARCELLES"),
      ),
      body: StreamBuilder(
        stream: databaseService.getSavedParcelles(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelle ajoutée.",
                    style: TextStyle(fontSize: 23)),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data.docs.length);
                  final MyPpolygon myPpolygon =
                      MyPpolygon.fromMap(snapshot.data.docs[index].data());
                  return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (cntx) => SavedParcView(
                                myPpolygon: myPpolygon,
                              ))),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                              leading: Text(getResponsefromParcelle(myPpolygon),
                                  style: TextStyle(fontSize: 19)),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete_forever_rounded),
                                      color: Colors.red,
                                      onPressed: () => createDialog1(
                                          context, uid, myPpolygon.id),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit_outlined),
                                      color: Colors.green,
                                      onPressed: () async {
                                        createDialog(
                                          context,
                                          myPpolygon.id,
                                        ).then((value) {
                                          if (value) {
                                            toast.Fluttertoast.showToast(
                                                msg:
                                                    "Réference ajoutée avec succés",
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.green
                                                    .withOpacity(0.8),
                                                gravity:
                                                    toast.ToastGravity.TOP);
                                          } else {
                                            toast.Fluttertoast.showToast(
                                                msg: "echéc",
                                                timeInSecForIosWeb: 3,
                                                backgroundColor:
                                                    Colors.red.withOpacity(0.8),
                                                gravity:
                                                    toast.ToastGravity.TOP);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ));
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

String getResponsefromParcelle(MyPpolygon myPpolygon) {
  if (myPpolygon.reference == "null") {
    return "Parcelle non affectée";
  } else {
    return "Parcelle n° ${myPpolygon.reference}";
  }
}
