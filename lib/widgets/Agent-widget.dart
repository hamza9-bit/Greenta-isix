import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/AffectationScreen.dart';
import 'package:CTAMA/screens/Agent/Ag-accounts.dart';
import 'package:CTAMA/screens/Agent/ag-experts.dart';
import 'package:CTAMA/screens/Agri_risque_formulaire.dart';
import 'package:CTAMA/screens/rapports.dart';
import 'package:CTAMA/screens/SinistreScreen.dart';
import 'package:CTAMA/screens/ajouter-agence.dart';
import 'package:flutter/material.dart';

class Agentpage1 extends StatefulWidget {
  const Agentpage1({
    Key key,
  }) : super(key: key);
  @override
  _Agentpage1State createState() => _Agentpage1State();
}

class _Agentpage1State extends State<Agentpage1> {
  int _currentIndex = 0;

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
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: height / 28.1),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: height / 42.15,
          crossAxisSpacing: width / 41.1,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgAgriculteurs()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.agriculture_rounded,
                name: "Agriculteurs",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SinistreView()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.dangerous,
                name: "Sinistres",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Affectation()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.landscape,
                name: "Affectation",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ajoutagence()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.location_city_sharp,
                name: "Nos agences",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Rapports()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.file_copy,
                name: "Rapports",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Experts()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.person,
                name: "Nos experts",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
