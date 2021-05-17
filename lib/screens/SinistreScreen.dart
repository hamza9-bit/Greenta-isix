import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:CTAMA/screens/Agent/saved_agences_view.dart';

class SinistreView extends StatelessWidget {
  SinistreView({
    Key key,
    this.uid,
    this.readOnly = false,
    this.iamAgri = false,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
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
                child: Text("NO SINISTRES ENCORE.",
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
                                  showImagesModal(
                                      context, mysinistre.imagesUrl);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: Image.network((mysinistre
                                                          .imagesUrl
                                                      as List<dynamic>)
                                                  .isNotEmpty
                                              ? mysinistre.imagesUrl[0]
                                                  .toString()
                                              : "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png")
                                          .image,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      child: Text(
                                          "+${mysinistre.imagesUrl.length}",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    )
                                  ],
                                ),
                              ),
                              title: Text("${mysinistre.agriId}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  "Parcelle N°${mysinistre.parcelleRef}",
                                  style: TextStyle(fontSize: 18)),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (!iamAgri)
                                      IconButton(
                                        icon: Icon(Icons.send_outlined),
                                        color: Colors.green,
                                        onPressed: () async {
                                          showParcellesModal(context)
                                              .then((value) {
                                            if (value != null) {
                                              databaseService.makeExpertCansee(
                                                  mysinistre.sinisteid, value);
                                            }
                                          });
                                        },
                                      ),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever_outlined),
                                      color: Colors.red,
                                      onPressed: () async {
                                        await databaseService.deleteSinistre(
                                            mysinistre.sinisteid);
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
                child: Text("aucune expert encore.",
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
                      child: getCard(myuser));
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

  Widget getCard(Myuser myuser) {
    return ListTile(
      tileColor: Colors.blue[800],
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
}
