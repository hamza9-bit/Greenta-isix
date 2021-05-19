

import 'package:flutter/material.dart';


class BodyIncendie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
      child: Column(
        
        children: <Widget> [
          Text("Protégez votre production contre l’incendie",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("Le contrat d’assurance incendie récolte de la CTAMA permet aux agriculteurs d’assurer leur production sur pieds, stockés en meules de pailles ou de foin contre le risque incendie.",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
     Text("Pour conclure ce contrat, il faut déclarer :",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
     Text("Récolte sur pieds                                                                      ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text("Toute information qui concerne la parcelle assurée,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("La nature de production, le rendement attendu et le prix de vente.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
         Text("  Stockage (en plein air)                                                               ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text("Nature du stock, la quantité et le prix.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
                     Text("  Stockage (sous hangars)                                                                ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text("La valeur du bâtiment, la valeur des produits stockés à l’intérieur et l’emplacement du hangar.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
            SizedBox(
               height:20,
             ),

       Text("Que faire en cas de sinistre ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
        Text("Une déclaration doit être envoyée à la CTAMA (par télégramme ou par écrit via une agence CTAMA) dans un délai ne dépassant pas les cinq jours et présenter les pièces suivantes :",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
            SizedBox(
               height:20,
             ), 
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Attestation de la protection civile.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Procès verbal auprès des autorités.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ), 
             Text("Suite à la déclaration, l’expert évalue les dégâts.              ",style: TextStyle(fontSize: 15,color: Colors.red[700],fontWeight: FontWeight.bold,height: 1,),textAlign: TextAlign.left,),
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