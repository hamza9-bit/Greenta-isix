import 'package:flutter/material.dart';

class BodySerre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        
        children: <Widget> [
          Text("ASSURANCE MULTIRISQUES SERRES",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.justify,),
           SizedBox(
               height:30,
             ),
          Text("Les risques Grêle, incendie, foudre, neige, tempête, explosion… peuvent détruire tout ou une partie de vos serres",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
          Text("Assurances CTAMA est toujours là et vous propose un contrat d’assurance « multirisques serres » avec une panoplie de garanties à même de sécuriser vos serres.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),
            SizedBox(
               height:20,
             ),
          Text("Quel est l’objet de la garantie du contrat d’assurances « multirisques serres »?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.justify,),
          SizedBox(
               height:20,
             ),
     new  ListTile(
       leading: new MyBullet(),
       title: Text("Les serres couvertes en verres ou plastiques ainsi que leurs équipements à l’exclusion des serres dont les verres ont une épaisseur inférieure à 2 mm,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

       new  ListTile(
       leading: new MyBullet(),
       title: Text("Les bâtiments de chaufferie et bâtiments annexes,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

       new  ListTile(
       leading: new MyBullet(),
       title: Text("Les installations fixes et agencements dans les serres et bâtiments assuré,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

        new  ListTile(
       leading: new MyBullet(),
       title: Text("Les installations de chauffage, de climatisation et les générateurs de gaz,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

        new  ListTile(
       leading: new MyBullet(),
       title: Text("Les citernes de carburants et leur contenu,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

        new  ListTile(
       leading: new MyBullet(),
       title: Text("Les plantes cultivées sous les serres,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

        new  ListTile(
       leading: new MyBullet(),
       title: Text("Le matériel utilisé pour les cultures sous serres pour autant que ces cultures soient assurées.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:30,
             ),
        Text("Quels sont les risques assurés ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.left,),
             SizedBox(
               height:20,
             ),
        Text("La CTAMA garantit les serres contre :                             ",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.justify,),

            SizedBox(
               height:20,
             ),
             new  ListTile(
       leading: new MyBullet(),
       title: Text(" La grêle, l’incendie, la foudre.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

       new  ListTile(
       leading: new MyBullet(),
       title: Text("La congélation de la neige et/ou de l’eau retenue par les constructions, provoquant à la suite d’un abaissement de température, l’éclatement des surfaces vitrées,.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
           

           new  ListTile(
       leading: new MyBullet(),
       title: Text("Les explosions : la CTAMA assure les dommages matériels causés par les explosions de toutes natures consécutives, c'est-à-dire toute action subite et violente de la pression ou la dépression de gaz ou de vapeurs.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
           

            new  ListTile(
       leading: new MyBullet(),
       title: Text("  La chute d’aéronefs et dépassement du mur du son.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
      
      
        new  ListTile(
       leading: new MyBullet(),
       title: Text(" La neige : l’accumulation des flocons de neige entraînant un effondrement partiel ou total de la construction. Il est possible d’étendre la couverture en ajoutant d’autres garanties (tel que le matériel électronique).",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
        
        
        new  ListTile(
       leading: new MyBullet(),
       title: Text("  La tempête : les serres sont assurées contre les dommages qui peuvent avoir lieu suite à la tempête de vent (ne dépassant pas les 80km/h) sous toutes ses formes ou suite aux dégâts causés par la tempête dans un rayon de 5km autour du lieu du risque assuré.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
      SizedBox(
               height:20,
             ),
        Text("Que faire pour souscrire ce contrat ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.justify,),
           SizedBox(
               height:30,
             ),
             Text("Une Expertise préalable sera effectuée pour évaluer les serres.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),
SizedBox(
               height:20,
             ),
        Text("Que faire en cas de sinistre ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.justify,),
           SizedBox(
               height:30,
             ),
             Text("Déclaration du sinistre dans un délai de 05 jours ouvrables.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),

             
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
    shape: BoxShape.circle,
  ),
  );
  }
}