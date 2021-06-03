import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:CTAMA/screens/sinsitre.dart';

import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class AgriSinistre extends StatelessWidget {
  AgriSinistre(
      {Key key,
      this.uid,
      this.readOnly = false,
      this.iamAgri = false,
      this.cin,
      this.nbsin})
      : super(key: key);

  final String uid;
  final String cin;
  final bool readOnly;
  final bool iamAgri;
  final int nbsin;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (cntx) => Sinistre(
                      name: cin,
                      nbsin: nbsin,
                      uid: uid,
                    ))),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: uid != null
            ? databaseService.getSinistresWFilters(uid)
            : databaseService.getSinistres(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucun Sinitre Ajouté",
                    style: TextStyle(fontSize: 23)),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final Mysinistre mysinistre =
                      Mysinistre.fromMap(snapshot.data.docs[index].data());
                  return Card(
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
                                    color: Colors.grey, shape: BoxShape.circle),
                                child: Text("+${mysinistre.imagesUrl.length}",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                        title: Text("${mysinistre.agriId}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text("Parcelle N°${mysinistre.parcelleRef}",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  );
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

Widget getCard(Myuser myuser) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.orange[200],
            borderRadius: BorderRadius.circular(60 / 2),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(myuser.imageUrl != null
                  ? myuser.imageUrl
                  : "https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              myuser.email,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              myuser.name,
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
          ],
        )
      ],
    ),
  );
}
