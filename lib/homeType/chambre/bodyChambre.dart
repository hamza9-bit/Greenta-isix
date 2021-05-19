import 'package:flutter/material.dart';

class BodyChambre extends StatefulWidget {
  @override
  _BodyChambreState createState() => _BodyChambreState();
}

class _BodyChambreState extends State<BodyChambre> {
  @override
  Widget build(BuildContext context) {
   return Container(
      child: Column(
        
        children: <Widget> [
          Text("Chambres frigorifiques",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("Les chambres frigorifiques peuvent être assurées vides ou avec un stock contre l’incendie. Le contenu est aussi couvert en cas de défaillance de l’équipement de refroidissement.",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
            Text("Le contrat d'assurance est d'une durée d'un an ferme.",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
      ///////////
              Text("Conditions d'assurance",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
            Text("Pour assurer les chambres frigorifiques, il faut :                              ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text("Estimer la valeur des bâtiments et des équipements.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("Présenter les factures du stock.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),

              new  ListTile(
       leading: new MyBullet(),
       title: Text("Effectuer une visite préalable d’un expert.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
       
               SizedBox(
               height:30,
             ),
        ],
      ),
    );
     
  }
}


class MyBullet extends StatelessWidget{  // lista puces
  @override
  Widget build(BuildContext context) {
    return new Container(
    height: 8.0,
    width: 8.0,
    decoration: new BoxDecoration(
    color: Colors.blue[700],
    shape: BoxShape.rectangle,
  ),
  );
  }
}