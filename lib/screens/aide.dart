import 'package:CTAMA/screens/accueil.dart';

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
        assuranceType(
          context,
          'assets/images/aide/grele.jpg',
        ),
        assuranceType(
          context,
          'assets/images/aide/Assurance mortalité du bétail.jpg',
        ),
        assuranceType(
          context,
          'assets/images/aide/Mutirisques serres.jpg',
        ),
        assuranceType(
          context,
          'assets/images/aide/Responsabilité civile agriculteurs.jpg',
        ),
        assuranceType(
          context,
          'assets/images/aide/Assurance multirisques apicole.jpeg',
        ),
        assuranceType(
          context,
          'assets/images/aide/Chambres frigorifiques.jpg',
        ),
      ],
    );
  }

  Widget assuranceType(
    BuildContext context,
    String img,
  ) {
    return Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
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
