import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/Risque.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgriRisques extends StatefulWidget {
  final String uid;

  const AgriRisques({Key key, this.uid}) : super(key: key);
  @override
  AgriRisquesState createState() {
    return new AgriRisquesState();
  }
}

class AgriRisquesState extends State<AgriRisques> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Risques"),
      ),
      body: FutureBuilder(
          future: DatabaseService().getRisqueByuid(widget.uid),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              final Risque risque = Risque.fromMap(snapshot.data.data());

              return Container(
                child: DataTable(
                    sortAscending: true,
                    dataRowHeight: height / 9.5,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text("Question"),
                        numeric: false,
                        tooltip: "To display question",
                      ),
                      DataColumn(
                        label: Text("Réponse"),
                        numeric: false,
                        tooltip: "To display response",
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: [
                          DataCell(
                            Text("Travaillez-vous seul ? "),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans1)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                                "Utilisez-vous des chiens pour vos activités de garde ? "),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans2)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                                "Avez-vous déjà eu une assurance pour votre activite indépendante actuelle au cours des 5 dernières années ? "),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans3)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                                "Avez-vous subi des dommages au cours des 5 dernières années ?"),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans4)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                                "Utilisez-vous des substances dangereuses pour l'environnement comme peintures, vernis, produits de nettoyages et carburants: essence ou mazout ?"),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans5)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                                "Avez-vous des machines de travail et tracteurs pour travaux sous contrat et location ? "),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Container(
                              child: (getResponsefromBoolean(risque.ans6)),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text("qu'est ce que vous produisez ?"),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text("${risque.ans7}"),
                            showEditIcon: false,
                            placeholder: false,
                          )
                        ],
                      ),
                    ]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

Widget getResponsefromBoolean(bool res) {
  return res
      ? Icon(
          Icons.verified_rounded,
          color: Colors.green[900],
        )
      : Icon(
          Icons.dangerous,
          color: Colors.red[900],
        );
}
