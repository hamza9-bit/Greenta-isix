import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'rapportDetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Rapportagri extends StatefulWidget {
  const Rapportagri({
    Key key,
    this.uid,
  }) : super(key: key);
  final String uid;
  @override
  _RapportagriState createState() => _RapportagriState();
}

class _RapportagriState extends State<Rapportagri> {
  bool isDownload = false;

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Text("Rapports"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder(
      stream: databaseService.getrapports1(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data.docs.isEmpty) {
            return Center(
              child:
                  Text("Aucun Rapport Ajouté", style: TextStyle(fontSize: 23)),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final Mysinistre myrapport = Mysinistre.fromCheckedMap(
                      snapshot.data.docs[index].data());
                  return GestureDetector(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (cntx) =>
                            AttachmentSheet(myrapport: myrapport),
                        elevation: 10,
                        isDismissible: true,
                        enableDrag: true,
                        isScrollControlled: false),
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (AttachmentSheet(
                                  myrapport: myrapport,
                                ))))*/
                    child: getCard(myrapport),
                  );
                });
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getCard(Mysinistre myrapport) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60 / 2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/rapport.png"),
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
                myrapport.sinisteid,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${myrapport.date.toString().split("@")[1]}",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ],
          )
        ],
      ),
    );
  }
}

bool isDownload = false;

Future<void> downloadFile(String url) async {
  Directory appDocDir = await path.getExternalStorageDirectory();

  String appDocPath = appDocDir.path;
  String path1 = appDocDir.hashCode.toString();

  print(appDocPath);

  HttpClient client = new HttpClient();

  await client
      .getUrl(Uri.parse(url.split("@")[0]))
      .then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) async {
    await response.pipe(
        new File(appDocPath + "/${path1}.${url.split("@")[1]}").openWrite());
  });
  final String finalpath = appDocPath + "/" + path1 + "." + url.split("@")[1];
  toast.Fluttertoast.showToast(
      msg: "fichier telechargé avec succés dans $finalpath",
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.green.withOpacity(0.8),
      gravity: toast.ToastGravity.TOP);
}

class AttachmentSheet extends StatefulWidget {
  final Mysinistre myrapport;

  const AttachmentSheet({Key key, this.myrapport}) : super(key: key);

  @override
  _AttachmentSheetState createState() => _AttachmentSheetState();
}

class _AttachmentSheetState extends State<AttachmentSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    final textStyle = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17);

    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          height: height / 1.78,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              SizedBox(height: height / 30),
              Image(
                image: AssetImage("assets/images/rapport.png"),
                width: width / 4,
              ),
              SizedBox(height: height / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(
                      label: 'Date de creation',
                      value:
                          "${widget.myrapport.date.toString().split("@")[0]}",
                      labelStyle: textStyle,
                      valueStyle: TextStyle()),
                  SizedBox(height: height / 30),
                  _buildText(
                      label: 'Parcelle',
                      value: "${widget.myrapport.parcelleRef}",
                      labelStyle: textStyle,
                      valueStyle: TextStyle()),
                  SizedBox(height: height / 30),
                  _buildText(
                      label: 'ID Sinister ',
                      value: "${widget.myrapport.sinisteid}",
                      labelStyle: textStyle,
                      valueStyle: TextStyle()),
                  SizedBox(height: height / 30),
                  _buildText(
                      label: 'CIN Expert',
                      value:
                          "${widget.myrapport.date.toString().split("@")[1]}",
                      labelStyle: textStyle,
                      valueStyle: TextStyle()),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isDownload = true;
                  });

                  downloadFile(widget.myrapport.filePath).then((value) {
                    setState(() {
                      isDownload = false;
                    });
                  });
                },
                child: AnimatedContainer(
                    height: height / 14,
                    width: !isDownload ? 200 : 50,
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.circular(isDownload ? 25.0 : 25.0)),
                    child: Center(
                      child: isDownload
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.redAccent),
                            )
                          : Text("Télécharger ",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)
                                      .copyWith(fontWeight: FontWeight.bold)),
                    )),
              )
            ],
          ),
        )
      ])),
    );
  }

  Widget _buildText(
      {String label,
      String value,
      TextStyle labelStyle,
      TextStyle valueStyle}) {
    return RichText(
        text: TextSpan(style: labelStyle, children: [
      TextSpan(text: label != null ? '$label: ' : ' ', style: labelStyle),
      TextSpan(text: value != null ? '$value ' : 'N/A', style: valueStyle)
    ]));
  }
}
