import 'dart:collection';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:flutter/cupertino.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NosAgences extends StatefulWidget {
  final LocationData location;

  NosAgences({
    this.location,
  });
  @override
  _NosAgencesState createState() => _NosAgencesState();
}

class _NosAgencesState extends State<NosAgences> {
  // Location
  LocationData _locationData;

  // Maps

  List<LatLng> markerLatLngs = <LatLng>[];

  GoogleMapController _googleMapController;

  Set<Marker> markers = HashSet<Marker>();

  String searchAddr;

  BitmapDescriptor _markerIcon;

  final DatabaseService databaseService = DatabaseService();
  //ids

  int _markerIdCounter = 1;

  // Type controllers

  bool _isMarker = false;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
    DatabaseService().getSavedMarkers().then((value) {
      if (value.data() != null) {
        setState(() {
          markers = HashSet<Marker>.from(
              Mymarker.fromMap(value.data()).geoPoint.map((e) {
            return Marker(
                markerId: MarkerId("${e.hashCode}"),
                position: LatLng(e.latitude, e.longitude));
          }));
        });
      }
    });
    _locationData = widget.location;
  }

  // This function is to change the marker icon

  // Set Markers to the map

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  Widget _buildHoleWidget() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_locationData.latitude, _locationData.longitude),
                  zoom: 16,
                ),
                markers: markers,
                myLocationEnabled: true,
              ),
            ),
            Positioned(
              child: SizedBox(
                  height: 50,
                  width: 30,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
              top: MediaQuery.of(context).viewPadding.top + 10,
              left: 30,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildHoleWidget();
  }
}
