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
    return Scaffold(
      appBar: AppBar(
        title: Text("Risques"),
      ),
      body: FutureBuilder(
          future: DatabaseService().getRisqueByuid(widget.uid),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              final Risque risque = Risque.fromMap(snapshot.data.data());

              return Container(
                child: DataTable(sortAscending: true, columns: <DataColumn>[
                  DataColumn(
                    label: Text("Question"),
                    numeric: false,
                    tooltip: "To display first name of the Name",
                  ),
                  DataColumn(
                    label: Text("Reponse"),
                    numeric: false,
                    tooltip: "To display last name of the Name",
                  ),
                ], rows: <DataRow>[
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti thkey dfg dfgd fgddrh drh d "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans1)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti jadour "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans2)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti mle3bi "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans3)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti fesed "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans4)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("haya rouba "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans5)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti batata "),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text("${getResponsefromBoolean(risque.ans6)}"),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("enti thkey "),
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

String getResponsefromBoolean(bool res) {
  return res ? "Oui" : "Non";
}
