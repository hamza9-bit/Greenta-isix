import 'package:flutter/material.dart';


class BodyGrele extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget> [
          Text("Protégez votre exploitation agricole et sécurisez vos revenus",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("Parce que la chute de grêle peut en un instant détruire vos cultures et le fruit de vos efforts,",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
            Text("ASSURANCES CTAMA a pensé à vous avec le contrat d’assurance contre la grêle qui vous permet de garantir :",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text(" La perte de quantité de la production avant récolte et consécutive à la chute de grêle pour les grandes cultures, les cultures irriguées et les arboricultures (seuls les fruits sont assurés) selon les conditions particulières du contrat et pour une période limitée.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Les dommages subis par les pépinières suite à la chute de grêle ou passage d’un ouragan sur la base des frais de l’exploitation prévus pour les superficies sinistrées.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),

              Text("Un contrat souple selon vos choix",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
         Text("Suite à votre demande, il est possible de                                     ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text(" Prolonger la durée de couverture.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
             new  ListTile(
       leading: new MyBullet(),
       title: Text("  Couvrir la perte de qualité.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Diminuer ou augmenter le rendement et le prix déclaré lors de la souscription.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              Text("Comment souscrire un contrat d’assurance contre la grêle ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
                     Text(" Pour conclure un contrat d’assurance contre la grêle, il faut :                                    ",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
           SizedBox(
               height:20,
             ),
       new  ListTile(
       leading: new MyBullet(),
       title: Text(" Déclarer toutes les informations concernant la parcelle assurée (lieu et zones limitrophes).",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
            SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Déclarer la nature de la production, le rendement attendu et le prix de vente.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
            SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("  Déclarer tous les risques possibles.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
            SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Pour les contrats d’assurance des pépinières, l’assuré doit, lors de la souscription, déclarer la superficie totale exploitée et les frais nécessaires selon la superficie.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
            SizedBox(
               height:20,
             ),
Text("Quel est la cotisation d’assurance contre la grêle ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
           Text("Les tarifs appliqués pour calculer la cotisation d’assurance contre la grêle varient d’une région à une autre selon les caractéristiques climatiques de chaque région et la nature des culturess.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),
            SizedBox(
               height:20,
             ),  
       Text("Que faire en cas de sinistre ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Décaler la survenance du sinistre suite à la chute de grêle dans un délai ne dépassant pas les 05 jours.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text(" Prendre des mesures de sauvetage pour les arbres suite à la chute de grêle jusqu’à ce que les experts arrivent.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ), 
              Text("Comment se passe l’indemnisation ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
              new  ListTile(
       leading: new MyBullet(),
       title: Text("  L’évaluation des dégâts est effectuée par un expert.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text(" L’indemnisation se fait dans délai d’un mois à partir de la date de survenance du sinistre.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
               new  ListTile(
       leading: new MyBullet(),
       title: Text(" L’indemnisation ne doit pas dépasser la valeur assurée après déduction de la franchise appliquée dans le contrat.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
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