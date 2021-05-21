import 'package:flutter/material.dart';

//ha4i masta3mltha ken fel class ha4eka ?? wel acceuil
class IconListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function ontap;
  IconListTitle(
      {this.icon,
      this.text,
      this.ontap}); //hne temchi tawika 5aliha ha4i zeda walet s7i7a arj3 trah arj3 tawika

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0.8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.blue[100],
        ))),
        child: InkWell(
          splashColor: Colors.blue[400],
          onTap: ontap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigateIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function ontap;

  const NavigateIcon({this.icon, this.text, @required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0.8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.blue[100],
        ))),
        child: InkWell(
          splashColor: Colors.blue[400],
          onTap: ontap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
