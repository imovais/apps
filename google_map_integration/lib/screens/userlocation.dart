import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Userlocation extends StatefulWidget {
  const Userlocation({super.key});

  @override
  State<Userlocation> createState() => _UserlocationState();
}

class _UserlocationState extends State<Userlocation> {
  LatLng _myposition = LatLng(0, 0);

  CameraPosition initialposition =
      //my home 24.897316, 67.029621
      CameraPosition(target: LatLng(24.897316, 67.029621), zoom: 13.0);

  GoogleMapController? mapController;

  final Set<Marker> _markers = {};

  //Function
  Future<void> _getMyLocation() async {
    Location _location = Location();
    var getlocation = await _location.getLocation();
    _myposition = LatLng(getlocation.latitude!, getlocation.longitude!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMyLocation().then((value) => _markers.add(Marker(
        markerId: MarkerId("live"),
        position: _myposition,
        icon: BitmapDescriptor.defaultMarker)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Your Live Location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Text(
            _myposition.toString(),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          )
        ],
      )),
      body: GoogleMap(
        initialCameraPosition: initialposition,
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: _markers,
      ),
    );
  }
}
