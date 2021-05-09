import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/expert/rapport.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Expertscreen extends StatefulWidget {
  final Myuser myuser;

  const Expertscreen({Key key, this.myuser}) : super(key: key);

  @override
  _ExpertscreenState createState() => _ExpertscreenState();
}

class _ExpertscreenState extends State<Expertscreen> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () async {
              AuthenticationService().signOut().then((value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (cntx) => LoginScreen()),
                      (route) => false);
                }
              });
            },
            label: Text(
              'Déconnexion',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text("Expert panel"),
        ),
      ),
      body: getBody(),
    );
  }

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

  Widget getBody() {
    return StreamBuilder(
      stream: databaseService.getSinistresWFiltersForExpert(widget.myuser.id),
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
                final Mysinistre mysinistre =
                    Mysinistre.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) => Rapportexpertise(
                              cin: widget.myuser.cin,
                              parcelle: "parcelle n°${mysinistre.parcelleRef}",
                              sinistre: "Sinistre n°${mysinistre.sinisteid}",
                            ))),
                    child: getCard(mysinistre));
              },
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget getCard(Mysinistre mysinistre) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        subtitle: Text(
          "parcelle n°${mysinistre.parcelleRef}",
          style: TextStyle(color: Colors.grey, fontSize: 17),
        ),
        leading: GestureDetector(
          onTap: () async {
            showImagesModal(context, mysinistre.imagesUrl);
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: Image.network((mysinistre.imagesUrl
                                as List<dynamic>)
                            .isNotEmpty
                        ? mysinistre.imagesUrl[0].toString()
                        : "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png")
                    .image,
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                child: Text("+${mysinistre.imagesUrl.length}",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
        title: Container(
          child: Text(
            "Sinistre n° ${mysinistre.sinisteid}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}
