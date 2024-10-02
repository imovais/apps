import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Google Map Controller
  GoogleMapController? mapController;

  CameraPosition initialposition =
      //my home 24.897316, 67.029621
      CameraPosition(target: LatLng(24.897316, 67.029621), zoom: 13.0);

  // Create a set to store marker
  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCustomMarket();
    _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.897316, 67.029621),
        infoWindow: InfoWindow(
            title: "Muhammad Ovais Khan House", snippet: "A Beautiful House"),
        icon: _customIcon));

    _markers.add(Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.892187, 67.028145),
        infoWindow: InfoWindow(title: "Zahoor Ahmed", snippet: "Chishti Nagar"),
        icon: _customIcon));
  }

  BitmapDescriptor _customIcon = BitmapDescriptor.defaultMarkerWithHue(200);

  Future<void> _loadCustomMarket() async {
    print("workign 1111111");
    final BitmapDescriptor customIcom = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(20.0, 20.0)),
        "assets/images/car_marker.png");

    setState(() {
      _customIcon = customIcom;
      print(_customIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _loadCustomMarket();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Google Map Integration'),
            Image(
              image: AssetImage('assets/images/car_marker.png'),
              width: 48,
              height: 48,
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          initialCameraPosition: initialposition,
          onMapCreated: (controller) {
            mapController = controller;
          },
          markers: _markers,
        ),
      ),
    );
  }
}
