import 'package:flutter/material.dart';


class BodyApicole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget> [
          Text("En tant qu’apiculteur, avez-vous pris toutes les mesures nécessaires pour protéger au mieux vos ruches et votre activité apicole?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("CTAMA innove et vous propose le produit « APICERTI »",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
              Text("APICERTI est un contrat multirisques apicoles qui permet aux apiculteurs d’assurer leurs ruches contre :",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("L'incendie,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text("Le vol,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text("La Mortalité naturelle ou accidentelle,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text("La mortalité due aux pesticides.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              Text("Également, assurances CTAMA vous propose des garanties optionnelles pour couvrir tous vos risques, telles que:",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("Les accidents de transport.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text("La mortalité due aux hautes températures supérieures à 40°Celsius.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               Text("Que faire en cas de sinistre ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Signaler immédiatement le sinistre à la CTAMA dès sa constatation.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text(" S’il s’agit d’un vol, d’un acte de vandalisme ou d’un incendie, déposer immédiatement une plainte auprès des autorités compétentes.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text(" En cas de mortalité, procéder à des prélèvements d’abeilles mortes, d’abeilles mourantes, de cires avec couvain et pollen et les stocker au congélateur, et informer immédiatement la CTAMA.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text(" Prendre des photos le jour même du sinistre, si possible, pour appuyer le rapport.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:40,
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