import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

import 'package:doctor_v2/nurse_data/model/appointment_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/calling/calling.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/doctor_patient_options/doctor_patient_options_screen.dart';
import 'package:doctor_v2/nurse_views/going_patient/map_final.dart';
import 'package:doctor_v2/nurse_views/going_patient/map_screen.dart';
import 'package:doctor_v2/nurse_views/going_patient/map_screen2.dart';
import 'package:doctor_v2/nurse_views/prescription/prescription_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/nurse_views/vital_sign/vital_sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:doctor_v2/nurse_views/going_patient/secrets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;



class GoingToPatientScreen extends StatefulWidget {
  String title;
  String body;
  String distance;
  String record_id;
  String request_id;
  //9.198021,12.498866
  double originLAT = 9.198021;
  double originLONG = 12.498866;
  //9.205333,12.482511
  double destinationLAT = 9.205333;
  double destinationLONG = 12.482511;
  GoingToPatientScreen({required this.title, required this.body, required this.distance, required this.record_id, required this.request_id});

  @override
  _GoingToPatientScreenState createState() {
    return _GoingToPatientScreenState();
  }
}

class _GoingToPatientScreenState extends State<GoingToPatientScreen> {
  bool isShowVial = false;
  bool gettingToken = false;

  String status = 'start';


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
      final positionStream = Geolocator.getPositionStream();
      positionStream.handleError((error) {
        print(error);
      }).listen((position) => print(position.toString()));

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
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

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/my_location_icon.png");
    return byteData.buffer.asUint8List();
  }

  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';


  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    print('log: start');
    try {
      // Retrieving placemarks from addresses
      //List<Location> startPlacemark = await locationFromAddress(_startAddress);
      //List<Location> destinationPlacemark = await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = widget.originLAT;

      double startLongitude = widget.originLONG;

      double destinationLatitude = widget.destinationLAT;
      double destinationLongitude = widget.destinationLONG;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      Uint8List imageData = await getMarker();
      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      print('log: add marker');

      // Adding the markers to the list
      setState(() {
        markers.add(startMarker);
        markers.add(destinationMarker);
      });

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

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
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
    print('log: start polylines');
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    print('log: ${result.points.length}');
    print('log: ${result.errorMessage}');
    print('log: ${result.status}');
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

  void _launchPhoneCall(phone) async {
    if (!await launch("tel://${phone}")) throw 'Could not launch $phone';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/icons/back-arrow_icon.png'),
          ),
          title: Text(widget.title),),
        body: Stack(children: [
          //MapViewFinal(originLAT: widget.originLAT, originLONG: widget.originLONG, destinationLAT: widget.destinationLAT, destinationLONG: widget.destinationLONG,),
          GoogleMap(
            markers: Set<Marker>.from(markers),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          // Show zoom buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.add),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.zoomIn(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.remove),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.zoomOut(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Show the place input fields & button for
          // showing the route
          // Show current location button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.orange.shade100, // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        /*
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  widget.originLAT,
                                  widget.originLONG,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                          */
                        _calculateDistance();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: ColorResources.COLOR_PURPLE_MID,
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(500, 100.0)),
                //borderRadius: BorderRadius.only(bottomRight: Radius.circular(100), bottomLeft: Radius.circular(100))
                //shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        status=='start'?Text('Click the start button', style: TextStyle(color: Colors.white, fontSize: 18),):
                        status=='goto'?Text('Going to Location', style: TextStyle(color: Colors.white, fontSize: 18),):
                        Text('Arrived', style: TextStyle(color: Colors.white, fontSize: 18),),
                        SizedBox(width: 15,),
                        GestureDetector(
                          onTap: (){
                            _launchPhoneCall('123456');
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: ColorResources.COLOR_PURPLE_DEEP,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.call, color: ColorResources.COLOR_WHITE,),
                              )),
                        )
                      ],),
                    SizedBox(height: 15,),
                    if(status=='goto')Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.distance}km Away', style: TextStyle(color: Colors.white, fontSize: 14),),
                          Text('Reach Time: 15 min', style: TextStyle(color: Colors.white, fontSize: 14),)
                        ],),
                    ),
                    SizedBox(height: 10,),
                    status=='start'?TextButton(
                      onPressed: (){
                        _calculateDistance();
                        setState(() {
                          status='goto';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Start', style: TextStyle(fontSize: 18),),
                      ),
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 44)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(ColorResources.COLOR_PURPLE_DEEP),
                        foregroundColor: MaterialStateProperty.all(ColorResources.COLOR_WHITE),
                      ),
                    ):
                    status=='goto'?TextButton(
                      onPressed: (){
                        setState(() {
                          status='arrived';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Confirm Arrival', style: TextStyle(fontSize: 18),),
                      ),
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 44)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(ColorResources.COLOR_PURPLE_DEEP),
                        foregroundColor: MaterialStateProperty.all(ColorResources.COLOR_WHITE),
                      ),
                    ):
                                   TextButton(
                      onPressed: (){
                        //VitalSign
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VitalSign(vitalSignId: widget.request_id,)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Get Started', style: TextStyle(fontSize: 18),),
                      ),
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 44)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(ColorResources.COLOR_PURPLE_DEEP),
                        foregroundColor: MaterialStateProperty.all(ColorResources.COLOR_WHITE),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],),
      )
      /*
      Consumer<NurseAuthProvider>(
          builder: (context, authProvider, child) {
          return Consumer<AppointmentNurseProvider>(
              builder: (context, appointmentProvider, child) {
                if(appointmentProvider.isLoading){
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: Text('Loading...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: ColorResources.COLOR_WHITE),),));
                }else {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(children: [
                              Image.asset('assets/icons/back-arrow_icon.png', ),
                            ],),
                          ),
                        ),
                      ),
                      title: Text(appointmentProvider.patientModel.firstName+' '+appointmentProvider.patientModel.otherName+' '+appointmentProvider.patientModel.lastName),),
                    body: Stack(children: [
                      MapView(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: ColorResources.COLOR_PURPLE_MID,
                            borderRadius: BorderRadius.vertical(top: Radius.elliptical(500, 100.0)),
                            //borderRadius: BorderRadius.only(bottomRight: Radius.circular(100), bottomLeft: Radius.circular(100))
                            //shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Arriving at Destination', style: TextStyle(color: Colors.white, fontSize: 18),),
                                    SizedBox(width: 15,),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: ColorResources.COLOR_PURPLE_DEEP,
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.call, color: ColorResources.COLOR_WHITE,),
                                        ))
                                  ],),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('3km Away', style: TextStyle(color: Colors.white, fontSize: 14),),
                                      Text('Reach Time: 15 min', style: TextStyle(color: Colors.white, fontSize: 14),)
                                    ],),
                                ),
                                SizedBox(height: 10,),
                                TextButton(
                                  onPressed: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Confirm Arrival', style: TextStyle(fontSize: 18),),
                                  ),
                                  style: ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minimumSize:
                                    MaterialStateProperty.all(Size(double.infinity, 44)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all(ColorResources.COLOR_PURPLE_DEEP),
                                    foregroundColor: MaterialStateProperty.all(ColorResources.COLOR_WHITE),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],),
                  );
                }
            }
          );
        }
      ),
      */
    ],);
  }
}
