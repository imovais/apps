import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_integration/screens/userlocation.dart';
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

  markerAdder() {
    _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.897316, 67.029621),
        infoWindow: InfoWindow(
            title: "Muhammad Ovais Khan House", snippet: "A Beautiful House"),
        icon: customMarket ?? BitmapDescriptor.defaultMarker));

    _markers.add(Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.892187, 67.028145),
      infoWindow: InfoWindow(title: "Zahoor Ahmed", snippet: "Chishti Nagar"),
      icon: customMarket ?? BitmapDescriptor.defaultMarker,
      onTap: () {
        print('Zahoor Ahmed House');
      },
    ));

    setState(() {});
  }

  //BitmapDescriptor _customIcon = BitmapDescriptor.defaultMarkerWithHue(200);

  BitmapDescriptor? customMarket;

  Future loadMarker() async {
    // Load the image as bytes
    final ByteData byteData =
        await rootBundle.load('assets/images/car_marker.png');
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    // Create BitmapDescriptor from bytes
    BitmapDescriptor customIcon =
        BitmapDescriptor.bytes(imageBytes, height: 30, width: 30);
    setState(() {
      customMarket = customIcon;
    });
    markerAdder();
  }

  // Future<void> _loadCustomMarket() async {
  //   print("workign 1111111");
  //   final BitmapDescriptor customIcom = await BitmapDescriptor.asset(
  //       ImageConfiguration(size: Size(20.0, 20.0)),
  //       "assets/images/car_marker.png");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMarker();
  }

  @override
  Widget build(BuildContext context) {
    print('bottom');

    // _loadCustomMarket();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Userlocation(),
                  )),
              icon: Icon(Icons.arrow_right_alt_outlined))
        ],
        title: Row(
          children: [
            Text('Google Map Integration'),
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
