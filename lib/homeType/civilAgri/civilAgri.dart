import 'package:CTAMA/homeType/civilAgri/bodyAgri.dart';

import 'package:flutter/material.dart';

class Civil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(60)),
                      child: SizedBox(
                        height: 599,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    image: DecorationImage(
                                      image: new AssetImage(
                                          'assets/images/aide/Responsabilité civile agriculteurs.jpg'),
                                      fit: BoxFit.cover,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BodyAgri(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
