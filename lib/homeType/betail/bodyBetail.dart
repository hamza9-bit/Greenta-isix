import 'package:flutter/material.dart';

class BodyBetail extends StatefulWidget {
  @override
  _BodyBetailState createState() => _BodyBetailState();
}

class _BodyBetailState extends State<BodyBetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 200),
            child: Text(
              "Vos animaux, votre cheptel, constituent le capital productif de votre exploitation agricole.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.orange[700],
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 200),
            child: Text(
              "Les soins que vous leur portez au quotidien témoignent de votre attachement à leur bien-être.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 1600),
            child: Text(
              "Quels sont les risques contre lesquels les différentes espèces d’animaux sont garanties ?",
              style: TextStyle(
                fontSize: 20,
                color: Colors.orange[700],
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 200),
            child: Text(
              "L’espèce bovine laitière de 6 mois à 10 ans , chevaline et asine de 6 mois à 13 ans et l'espèce mulassière de 6 mois à 15 ans et l’espèce cameline.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //////
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 100),
            child: Text(
              "La CTAMA garantit ces espèces désignées aux conditions particulières, durant une année ferme, contre:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Mortalité d’ordre naturelle ou accidentelle de votre cheptel.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Mortalité survenue 08 jours après naissancee.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),

          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Avortement 07 mois de gestation.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(
            height: 30,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Mortinatalité.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(
            height: 30,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Abattage d’urgence.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 100),
            child: Text(
              "Sauf les maladies contagieuses et les réformes économiques.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
                height: height / 843,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: height / 28,
          ),
          Text(
            "l’espèce volailles.",
            style: TextStyle(
              fontSize: 20,
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
              height: height / 421,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height / 28,
          ),
          Text(
            "C’est un risque très délicat vue la spécificité de l’élevage avicole qui est hors-sol (élevage industriel) dont les risques garantis sont multiples (d’ordre naturel ou accidentel).",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ), ////
          Text(
            "Soit une multirisque qui touche les élevages des poulets et des dindes pour les différentes catégories : chair, pondeuse, et reproducteur où la durée du contrat, le tarif et la modalité de remboursement sont variables selon la nature de l’élevage.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Quels sont les pièces à fournir pour la souscription du contrat ?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Liste du cheptel identifié à assurer (tableau de marquage),",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Liste du cheptel identifié à assurer (tableau de marquage),",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Visite préalable du vétérinaire.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Que faire en cas de sinistre ?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Déclaration du sinistre dans un délai de 24H à compter de la date de survenance du sinistre.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Le numéro de la vache et le type de sinistre.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Certificat médical « vétérinaire ».",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Tableau de marquage.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new ListTile(
            leading: new MyBullet(),
            title: Text(
              "Facture de vente « cas d’abattage d’urgence » et le certificat d’abattage.",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  // lista puces
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
