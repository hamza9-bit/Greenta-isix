import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class SinistreView extends StatelessWidget {
  SinistreView({
    Key key,
    this.uid,
    this.readOnly = false,
    this.iamAgri = false,
    this.mysinistre,
    this.myuser,
  }) : super(key: key);
  final Mysinistre mysinistre;
  final Myuser myuser;
  final String uid;
  final bool readOnly;
  final bool iamAgri;

  final DatabaseService databaseService = DatabaseService();

  showImagesModal(BuildContext context, List<dynamic> imageUrls) async {
    return showModalBottomSheet(
        context: context,
        builder: (cntx) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
            itemCount: imageUrls.length,
            itemBuilder: (cntx, index) {
              return Image.network(imageUrls[index]);
            }),
        elevation: 10,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false);
  }

  Future<String> showParcellesModal(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (cntx) => ExpertSelector(),
        elevation: 10,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true);
  }

  Future<bool> createDialog1(
      BuildContext context, int nbSinisitre, Mysinistre mysinistre) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("êtes-vous sûr de vouloir supprimer ce sinsitre ?"),
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
                  print(nbSinisitre);
                  print(mysinistre.sinisteid);
                  await databaseService.deleteSinistre(mysinistre.sinisteid);
                  await databaseService.reductionSinistre(
                      mysinistre, nbSinisitre);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("SINISTRES"),
      ),
      body: StreamBuilder(
        stream: uid != null
            ? databaseService.getSinistresWFilters(uid)
            : databaseService.getSinistres(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("PAS ENCORE DU SINISTRE.",
                    style: TextStyle(fontSize: 23)),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final Mysinistre mysinistre =
                      Mysinistre.fromMap(snapshot.data.docs[index].data());
                  return GestureDetector(
                      onTap: () => readOnly
                          ? ""
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (cntx) => AgrProfile(
                                    uid: mysinistre.agriId,
                                  ))),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                showImagesModal(context, mysinistre.imagesUrl);
                              },
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: Image.network((mysinistre
                                                    .imagesUrl as List<dynamic>)
                                                .isNotEmpty
                                            ? mysinistre.imagesUrl[0].toString()
                                            : "https://images.fosterwebmarketing.com/438/Fire_on_Farm_Land.jpeg")
                                        .image,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: Text(
                                        "+${mysinistre.imagesUrl.length}",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
                            title: Text("${mysinistre.agriId}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Parcelle N°${mysinistre.parcelleRef}",
                                style: TextStyle(fontSize: 18)),
                            trailing: uid != null
                                ? Container(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.send_outlined),
                                          color: Colors.green,
                                          onPressed: () async {
                                            showParcellesModal(context)
                                                .then((value) {
                                              if (value != null) {
                                                databaseService
                                                    .makeExpertCansee(
                                                        mysinistre.sinisteid,
                                                        value);
                                              }
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.delete_forever_outlined),
                                          color: Colors.red,
                                          onPressed: () => createDialog1(
                                              context,
                                              myuser.nbSinisitre,
                                              mysinistre),
                                        ),
                                      ],
                                    ),
                                  )
                                : IconButton(
                                    icon: Icon(Icons.send_outlined),
                                    color: Colors.green,
                                    onPressed: () async {
                                      showParcellesModal(context).then((value) {
                                        if (value != null) {
                                          databaseService.makeExpertCansee(
                                              mysinistre.sinisteid, value);
                                        }
                                      });
                                    },
                                  ),
                          ),
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

class ExpertSelector extends StatelessWidget {
  const ExpertSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      child: StreamBuilder(
        stream: DatabaseService().getExperts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Pas encore d'expert.",
                    style: TextStyle(fontSize: 23)),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final Myuser myuser =
                      Myuser.fromMap(snapshot.data.docs[index].data());
                  return GestureDetector(
                      onTap: () => Navigator.of(context).pop(myuser.id),
                      child: card1(myuser));
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

  Widget card1(Myuser myuser) {
    return Card(
      child: Container(
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage(
                        "assets/images/exp.png",
                      ),
                    )),
              ),
              Flexible(
                flex: 6,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myuser.email,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            softWrap: true),
                        RichText(
                          softWrap: true,
                          text: TextSpan(children: [
                            TextSpan(
                                text: myuser.cin,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                          ]),
                        ),
                      ],
                    )),
              ),
            ]),
      ),
    );
  }
}
