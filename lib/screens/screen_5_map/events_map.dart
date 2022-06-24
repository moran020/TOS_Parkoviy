import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tos_parkoviy_app/components/class_data_to_map.dart';
import 'dart:async';

// Карта с маркером мероприятия
class EventMap extends StatefulWidget {
  const EventMap({Key? key}) : super(key: key);

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  // Добавление маркера по переданым координатам из предыдущего раздела
  Future _addMarker() async {
    String comment = dataToMap.eventName;
    BitmapDescriptor marker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/pin_event.png',
    );
    _markers.add(Marker(
      markerId: const MarkerId('main target'),
      infoWindow: InfoWindow(title: comment),
      position: LatLng(dataToMap.eventLatitude, dataToMap.eventLongitude),
      icon: marker,
    ));

    setState(() {});
  }

  double zoomVal = 17.0;

// Кнопка увеличения масштаба
  Widget _zoomminusfunction() {
    return Align(
      alignment: const Alignment(0.98, 0.1),
      child: SizedBox(
          width: 45,
          child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: dataToMap.bgcolor,
              child: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                zoomVal--;
                _minus(zoomVal);
              })),
    );
  }

// Кнопка уменьшения масштаба
  Widget _zoomplusfunction() {
    return Align(
        alignment: const Alignment(0.98, -0.1),
        child: SizedBox(
          width: 45,
          child: FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: dataToMap.bgcolor,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                zoomVal++;
                _plus(zoomVal);
              }),
        ));
  }

// Функция увеличения масштаба
  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(dataToMap.eventLatitude, dataToMap.eventLongitude),
        zoom: zoomVal)));
  }

// Функция уменьшения масштаба
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(dataToMap.eventLatitude, dataToMap.eventLongitude),
        zoom: zoomVal)));
  }

  late DataToMap dataToMap;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    dataToMap = settings.arguments as DataToMap;

    _addMarker();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Карта'),
          centerTitle: true,
          backgroundColor: dataToMap.bgcolor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(dataToMap.eventLatitude, dataToMap.eventLongitude),
                  zoom: zoomVal,
                ),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                markers: _markers,
                zoomControlsEnabled: false),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade500),
                      color: Colors.white),
                  width: 400,
                  height: 100,
                  child: Text(dataToMap.eventName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                )),
            _zoomminusfunction(),
            _zoomplusfunction(),
          ],
        ));
  }
}
