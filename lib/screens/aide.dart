import 'package:CTAMA/homeType/apicole/apicole.dart';
import 'package:CTAMA/homeType/betail/betail.dart';
import 'package:CTAMA/homeType/chambre/chambre.dart';
import 'package:CTAMA/homeType/civilAgri/civilAgri.dart';
import 'package:CTAMA/homeType/grele/grele.dart';
import 'package:CTAMA/homeType/incendie/incendie.dart';
import 'package:CTAMA/homeType/navire/navire.dart';
import 'package:CTAMA/homeType/serres/serre.dart';
import 'package:CTAMA/screens/accueil.dart';
import 'package:CTAMA/screens/contact.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/widgets/background-image.dart';

import 'package:flutter/material.dart';

class Aide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: <Widget>[
        assuranceType(context, 'assets/images/aide/grele.jpg',
            'Assurance grêle', () => Grele()),
        assuranceType(
            context,
            'assets/images/aide/Assurance mortalité du bétail.jpg',
            'Assurance mortalité du bétail',
            () => Betail()),
        assuranceType(context, 'assets/images/aide/incendie.jpg',
            'Assurance incendie', () => Incendie()),
        assuranceType(context, 'assets/images/aide/Mutirisques serres.jpg',
            'Mutirisques serres', () => Serre()),
        assuranceType(
            context,
            'assets/images/aide/Responsabilité civile agriculteurs.jpg',
            'Responsabilité civile agriculteurs',
            () => Civil()),
        assuranceType(context, 'assets/images/aide/Corp navire de pêche.jpeg',
            'Corp navire de pêche', () => Navire()),
        assuranceType(
            context,
            'assets/images/aide/Assurance multirisques apicole.jpeg',
            'Assurance multirisques apicole',
            () => Apicole()),
        assuranceType(context, 'assets/images/aide/Chambres frigorifiques.jpg',
            'Chambres frigorifiques', () => Chambre()),
      ],
    );
  }

  Widget assuranceType(
    BuildContext context,
    String img,
    String text1,
    Function onTap,
  ) {
    return Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => onTap())),
              ),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                image: DecorationImage(
                  image: new AssetImage(img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Column(
           
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      text1,
                      style: TextStyle(
                          fontFamily: 'home',
                          color: Colors.black,
                          fontSize: 9.999),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
