import 'package:CTAMA/screens/Agent/Agences.dart';
import 'package:CTAMA/screens/NosAgences.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Viewagence extends StatefulWidget {
  @override
  _ViewagenceState createState() => _ViewagenceState();
}

class _ViewagenceState extends State<Viewagence> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Check Location Permissions, and get my location
  void _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('NOS AGENCES'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _locationData != null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NosAgences(
                            location: _locationData,
                          )))
              : null,
          backgroundColor: Colors.orange,
          label: Row(
            children: <Widget>[
              Text(
                'Visualizer',
                style: TextStyle(color: Colors.black87),
              ),
              Icon(
                Icons.map,
                color: Colors.black87,
              ),
            ],
          )),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'localisation agence',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        )),
      ),
    );
  }
}
