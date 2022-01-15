import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;


class MapView extends StatefulWidget {
  double originLAT;
  double originLONG;
  double destinationLAT;
  double destinationLONG;
  MapView({required this.originLAT,required this.originLONG,required this.destinationLAT,required this.destinationLONG});
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  bool isLoading = true;

  String? _placeDistance;

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  double startLatitude = 9.202748;//, 12.477022),
  double destinationLatitude = 9.205553;//, 12.487584),
  Set<Marker> markers = {
    /*
    Marker(
      markerId: MarkerId('current location'),
      position: LatLng(9.202748, 12.477022),
      infoWindow: InfoWindow(
        title: 'current location',
        snippet: 'current location',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: MarkerId('destination location'),
      position: LatLng(9.205553, 12.487584),
      infoWindow: InfoWindow(
        title: 'destination location',
        snippet: 'destination location',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    */
  };

  //_calculateDistance()
  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }


  // For storing the current position
  //late Position _currentPosition;
  // Initial location of the Map view
  //destination 9.205553, 12.487584
  CameraPosition _initialLocation = CameraPosition(target: LatLng(9.202748, 12.477022), zoom: 15.0,);

// For controlling the view of the Map
  late GoogleMapController mapController;

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      Marker startPlacemark = Marker(
        markerId: MarkerId('current location'),
        position: LatLng(9.202748, 12.477022),
        infoWindow: InfoWindow(
          title: 'current location',
          snippet: 'current location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      Marker destinationPlacemark =
      Marker(
        markerId: MarkerId('destination location'),
        position: LatLng(9.205553, 12.487584),
        infoWindow: InfoWindow(
          title: 'destination location',
          snippet: 'destination location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = 9.202748;

      double startLongitude = 12.477022;

      double destinationLatitude = 9.205553;
      double destinationLongitude = 12.487584;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(widget.originLAT, widget.originLONG),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: "_startAddress",
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(widget.destinationLAT, widget.destinationLONG),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: "_destinationAddress",
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      await Future.delayed(const Duration(seconds: 15));
      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        isLoading = false;
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBAIpR0sqDMtDAwKAc0ilVX5MDRLTqKwaI',
      //'AIzaSyBGVJGsIL7-6gZUlF2afEZOUiczhoogkYk', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    print('============');
    print(PointLatLng(startLatitude, startLongitude));
    print(PointLatLng(destinationLatitude, destinationLongitude));
    print(result.points);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  // Method for retrieving the current location
  /*
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      //await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //_calculateDistance().then((value) => print(value));
    //double startLatitude = 9.202748;//, 12.477022),
    //double destinationLatitude = 9.205553;//, 12.487584),


    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            if(isLoading)Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...', style: TextStyle(fontSize: 18),),
                  ],
                )],),
            ),
            GoogleMap(
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              markers: Set<Marker>.from(markers),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            TextButton(onPressed: ()async{
              //await _createPolylines(9.202748, 12.477022, 9.205553, 12.487584);
              _calculateDistance().then((isCalculated) {
                if (isCalculated) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                          'Distance Calculated Sucessfully'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                          'Error Calculating Distance'),
                    ),
                  );
                }
                print(polylines.values);
              });
            }, child: Text('GO'))
          ],
        ),
      ),
    );
  }
}