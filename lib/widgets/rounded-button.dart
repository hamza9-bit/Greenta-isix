import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    Key key,
    @required this.buttonName,
    this.ontap,
  }) : super(key: key);
  final Function ontap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.08,
        width: size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green[800],
        ),
        child: InkWell(
          onTap: ontap,
          child: FlatButton(
            child: Text(
              buttonName,
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5)
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
