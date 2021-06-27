import 'dart:async';

import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/models/farm.dart';
import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:farmasyst_admin_console/services/constants.dart';
import 'package:farmasyst_admin_console/services/styles.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ViewFarm extends StatefulWidget {
  final Farm farm;
  final String farmId;
  ViewFarm({Key key, this.farm, this.farmId}) : super(key: key);

  @override
  _ViewFarmState createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {
  // final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Farm farm;
  var profileImage;
  bool isLoading = false;

  // Location
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  MapType _currentMapType = MapType.normal;
  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId(
        'test_marker_id_1',
      ),
      position: LatLng(6.699046065574141, -1.682570765007632),
      infoWindow:
          InfoWindow(title: 'Test Loc 1', snippet: 'A really good test'),
    ),
    Marker(
      markerId: MarkerId(
        'test_marker_id_2',
      ),
      position: LatLng(6.704757426069938, -1.6301282164668127),
      infoWindow:
          InfoWindow(title: 'Test Loc 2', snippet: 'A really good test'),
    ),
  };

  void enableLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  void grantLocationPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> getLocationData() async {
    _locationData = await location.getLocation();
    print(_locationData);
  }

  @override
  void initState() {
    farm = widget.farm;
    enableLocationService();
    grantLocationPermission();
    getLocationData();
    super.initState();
  }

// Maps
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(5.8142835999999996, 0.0746767),
      tilt: 59.440717697143555,
      zoom: 10.151926040649414);

  void _onMapTypeBtnPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  // @override
  // void dispose() {
  //   _mapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(24.0),
        width: size.width * 0.8,
        height: size.height * 0.9,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Farm Details',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                Tooltip(
                  message: "Close Window",
                  child: IconButton(
                      splashColor: Colors.red.withOpacity(0.3),
                      hoverColor: Colors.red.withOpacity(0.3),
                      splashRadius: 20,
                      highlightColor: Colors.white,
                      icon: Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: (farm.picture != null)
                            //       ? Image.network(
                            //           farm.picture,
                            //           width: 120,
                            //           height: 120,
                            //           fit: BoxFit.fill,
                            //         )
                            //       : Image.asset(
                            //           'assets/images/farmer.png',
                            //           width: 120,
                            //           height: 120,
                            //           fit: BoxFit.fill,
                            //         ),
                            // ),
                            SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: Styles.kRichTextStyle16,
                                    children: <TextSpan>[
                                      TextSpan(text: 'Farm Id\n'),
                                      TextSpan(
                                        text: widget.farm.farmId.toString(),
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: Styles.kRichTextStyle16,
                                    children: <TextSpan>[
                                      TextSpan(text: 'Location\n'),
                                      TextSpan(
                                        text: widget.farm.location,
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: Styles.kRichTextStyle16,
                                    children: <TextSpan>[
                                      TextSpan(text: 'Farm Size\n'),
                                      TextSpan(
                                        text: widget.farm.farmSize.toString() ??
                                            '',
                                        style: Styles.kRichTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Description\n'),
                              TextSpan(
                                text: widget.farm.description,
                                style: Styles.kRichTextStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Supervisor\n'),
                              if (widget.farm.supervisor != null) ...[
                                TextSpan(
                                  text: 'Name: ',
                                ),
                                TextSpan(
                                  text: widget.farm.supervisor['name'],
                                  style: Styles.kRichTextStyle16,
                                ),
                                TextSpan(
                                  text: 'Phone: ',
                                ),
                                TextSpan(
                                  text: widget.farm.supervisor['name'],
                                  style: Styles.kRichTextStyle16,
                                ),
                              ],
                              if (widget.farm.supervisor == null)
                                TextSpan(
                                  text: 'Not Assigned',
                                  style: Styles.kRichTextStyle,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // RichText(
                        //   textAlign: TextAlign.start,
                        //   text: TextSpan(
                        //     style: Styles.kRichTextStyle16,
                        //     children: <TextSpan>[
                        //       TextSpan(text: 'Location\n'),
                        //       TextSpan(
                        //         text: widget.farm.location,
                        //         style: Styles.kRichTextStyle,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: Styles.kRichTextStyle16,
                            children: <TextSpan>[
                              TextSpan(text: 'Crops on Farm\n'),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 5.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: List.generate(
                            farm.crops.length,
                            (index) => Chip(
                              backgroundColor: kPrimaryColor,
                              elevation: 5,
                              labelStyle: TextStyle(color: Colors.white),
                              label: Text('${farm.crops[index]}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      height: 550,
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: _currentMapType,
                            myLocationButtonEnabled: true,
                            compassEnabled: true,
                            mapToolbarEnabled: true,
                            markers: _markers,
                            initialCameraPosition: _kLake,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FloatingActionButton(
                                onPressed: _onMapTypeBtnPressed,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.map,
                                  size: 32.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
