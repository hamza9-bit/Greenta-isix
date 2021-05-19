import 'package:flutter/material.dart';

class BodyNavire extends StatefulWidget {
  @override
  _BodyNavireState createState() => _BodyNavireState();
}

class _BodyNavireState extends State<BodyNavire> {
  @override
  Widget build(BuildContext context) {
     return Container(
      child: Column(
        
        children: <Widget> [
          Text("Vous utilisez votre navire dans le cadre de votre activité professionnelle, certains évènements ou fortunes de mer peuvent vous empêcher d’exercer votre activité en toute sérénité :",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
          Text("Notre contrat d’assurance «corps navire de pêche» vous couvre contre les risques cités ci-dessous en vous offrant deux formules de garantie :",style: TextStyle(fontSize: 16,color: Colors.blue[700],),textAlign: TextAlign.center,),
            SizedBox(
               height:20,
             ),
    
     new  ListTile(
       leading: new MyBullet(),
       title: Text(" La « Tous risques » vous assure contre tous les dommages et pertes qui arrivent au navire assuré par tempête, naufrage, échouement, abordage, jet, feu, explosion pillage et généralement tous les accidents, évènements ou fortunes de mer,",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

       new  ListTile(
       leading: new MyBullet(),
       title: Text(" La perte totale et délaissement qui couvre l’armement spécial et le matériel de pêche.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
             SizedBox(
               height:20,
             ),
        Text("À noter qu’une visite préalable sera effectuée avant la souscription de ce contrat.",style: TextStyle(fontSize: 15,color: Colors.red[700],fontWeight: FontWeight.bold,height: 1,),textAlign: TextAlign.left,),
             SizedBox(
               height:30,
             ),
        Text("Que faire en cas de sinistre ?",style: TextStyle(fontSize: 20,color: Colors.orange[700],fontWeight: FontWeight.bold,height: 2,),textAlign: TextAlign.center,),
           SizedBox(
               height:30,
             ),
             new  ListTile(
       leading: new MyBullet(),
       title: Text("Déclarer la survenance du sinistre dans un délai de 05 jours.",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),

       new  ListTile(
       leading: new MyBullet(),
       title: Text("Présenter les papiers nécessaires (congé et permis de navigation).",style: TextStyle(fontSize: 14,color: Colors.black),textAlign: TextAlign.justify,),),
           
             
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