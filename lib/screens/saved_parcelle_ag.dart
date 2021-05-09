import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:CTAMA/screens/Agent/saved_agences_view.dart';
import '../polymaker/polymaker.dart';

class SavedParcelleag extends StatelessWidget {
  final Myuser myuser;
  final String id;

  SavedParcelleag({Key key, this.uid, this.myuser, this.id}) : super(key: key);

  Future<bool> createDialog(BuildContext context, String id) async {
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    final TextEditingController textEditingController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (cntx) {
        return new AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () async {
                if (globalKey.currentState.validate()) {
                  return await DatabaseService()
                      .setRef(textEditingController.text, id, uid)
                      .then((value) {
                    Navigator.of(context).pop(value);
                  });
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
                    return "longeur du Numéro de Reference doit etre superieur a 0";
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          title: Text("Enter Reference : "),
        );
      },
    );
  }

  Future<bool> createDialog1(BuildContext context, String uid, String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("voulez-vous vraiment vous supprimer cette parcelle ?"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            getLocation(context, enableDragMarker: true, myuser: null),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        title: Text("SAVED PARCELLES"),
      ),
      body: StreamBuilder(
        stream: databaseService.getSavedParcelles(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelles ajoutés.",
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
                              leading: Text(
                                  myPpolygon.reference != null
                                      ? "Parcelle n° ${myPpolygon.reference}"
                                      : "Parcelle n° $index",
                                  style: TextStyle(fontSize: 29)),
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
