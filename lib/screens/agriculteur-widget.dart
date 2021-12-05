import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';

import 'package:CTAMA/screens/saved_parcelle_ag.dart';
import 'package:flutter/material.dart';

class Agriculteurwidget extends StatefulWidget {
  final String id;
  final String uid;
  final Myuser myuser;

  const Agriculteurwidget({Key key, this.uid, this.id, this.myuser})
      : super(key: key);

  @override
  _AgriculteurwidgetState createState() => _AgriculteurwidgetState();
}

class _AgriculteurwidgetState extends State<Agriculteurwidget> {
  int _currentIndex = 0;
  Future<bool> createDialog(BuildContext context, String uid, String id) async {
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    final TextEditingController textEditingController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (cntx) {
        return new AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () async {},
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

  Widget _buildsinglecontainer(
      {IconData icon, String name, BuildContext context}) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 70,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedParcelleag(
                              uid: widget.myuser.id,
                            )));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.agriculture_rounded,
                name: "Parcelles",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
