import 'package:flutter/material.dart';

class BodyAgri extends StatefulWidget {
  @override
  _BodyAgriState createState() => _BodyAgriState();
}

class _BodyAgriState extends State<BodyAgri> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget> [
          Text("Vous êtes céréalier, éleveur, maraîcher, arboriculteur…nous connaissons bien les risques et les besoins liés à votre activité agricole. Nous vous proposons alors des assurances spécifiques pour vous permettre d’exercer votre métier en toute sérénité.",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("Notre contrat « responsabilité civile de l’agriculteur » vous permet d’être couvert contre les conséquences pécuniaires de la responsabilité civile que vous pouvez encourir en raison des dommages corporels, matériels et immatériels causés aux tiers suite à un accident résultant de l’activité de votre exploitation agricole.",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
            Text("Aussi cette garantie s’applique aux dommages causés par :",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text("Les batiments à usage d’exploitation, les arbres et les clotures.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("Les animeaux y compris les chiens.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),

              new  ListTile(
       leading: new MyBullet(),
       title: Text("Les biens et équipements mobiliers dont le sociétaire a la propriété, la garde ou l’usage. Notamment le matériel, les bicyclettes et les véhicules sans moteur de l’exploitation, etc.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
       
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