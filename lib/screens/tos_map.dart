import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';

// Карта со всеми точками
class TOSMap extends StatefulWidget {
  const TOSMap({Key? key}) : super(key: key);

  @override
  State<TOSMap> createState() => _TOSMapState();
}

class _TOSMapState extends State<TOSMap> {
  final Completer<GoogleMapController> _controller = Completer();

  double zoomVal = 14.0;

// Кнопка увеличения масштаба
  Widget _zoomminusfunction() {
    return SizedBox(
        width: 45,
        child: FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: bgColorMapAppBar,
            child: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              zoomVal--;
              _minus(zoomVal);
            }));
  }

// Кнопка уменьшения масштаба
  Widget _zoomplusfunction() {
    return SizedBox(
      width: 45,
      child: FloatingActionButton(
          heroTag: "btn2",
          backgroundColor: bgColorMapAppBar,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

// Функция увеличения масштаба
  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    LatLng pointerLocation = await _getCenter();
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: pointerLocation, zoom: zoomVal)));
  }

// Функция уменьшения масштаба
  Future<void> _plus(double zoomVal) async {
    LatLng pointerLocation = await _getCenter();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: pointerLocation, zoom: zoomVal)));
  }

// Функция определения центра карты
  Future<LatLng> _getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );
    return centerLatLng;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Карта ТОС',
        ),
        centerTitle: true,
        backgroundColor: bgColorMapAppBar,
      ),
      body: Stack(
        children: [
          // Карта
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: const LatLng(54.186415, 37.599950),
                    zoom: zoomVal,
                  ),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: _markers
                      .union(_markersHouses)
                      .union(_markersEvents)
                      .union(_markersPlaces)
                      .union(_markersOrganizations),
                  zoomControlsEnabled: false)),
          // Кнопки изменения масштаба
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(top: 170, right: 5),
            child: Column(
              children: [_zoomplusfunction(), _zoomminusfunction()],
            ),
          ),
          // Кнопки включения/включения маркеров
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 119,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    //Кнопки включения/выключения маркеров домов и мероприятий
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: isSelectedHouses,
                          color: bgColorHousesAppBar,
                          selectedColor: Colors.white,
                          fillColor: bgColorHousesAppBar,
                          borderRadius: BorderRadius.circular(4.0),
                          borderColor: bgColorHousesAppBar,
                          borderWidth: 2,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 53.0, minWidth: 170.0),
                              child: const Center(
                                  child: Text('Дома',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              isSelectedHouses[index] =
                                  !isSelectedHouses[index];
                              isSelectedHouses[index]
                                  ? loadMarkersHouses()
                                  : _markersHouses.clear();
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ToggleButtons(
                          isSelected: isSelectedEvents,
                          color: bgColorEventsAppBar,
                          selectedColor: Colors.white,
                          fillColor: bgColorEventsAppBar,
                          borderRadius: BorderRadius.circular(4.0),
                          borderColor: bgColorEventsAppBar,
                          borderWidth: 2,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 53.0, minWidth: 170.0),
                              child: const Center(
                                  child: Text('Мероприятия',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              isSelectedEvents[index] =
                                  !isSelectedEvents[index];
                              isSelectedEvents[index]
                                  ? loadMarkersEvents()
                                  : _markersEvents.clear();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Кнопки включения/выключения маркеров пространств и организаций
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: isSelectedPlaces,
                          color: bgColorPlacesAppBar,
                          selectedColor: Colors.white,
                          fillColor: bgColorPlacesAppBar,
                          borderRadius: BorderRadius.circular(4.0),
                          borderColor: bgColorPlacesAppBar,
                          borderWidth: 2,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 53.0, minWidth: 170.0),
                              child: const Center(
                                  child: Text('Пространства',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              isSelectedPlaces[index] =
                                  !isSelectedPlaces[index];
                              isSelectedPlaces[index]
                                  ? loadMarkersPlaces()
                                  : _markersPlaces.clear();
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ToggleButtons(
                          isSelected: isSelectedOrganizations,
                          color: bgColorOrganizationsAppBar,
                          selectedColor: Colors.white,
                          fillColor: bgColorOrganizationsAppBar,
                          borderRadius: BorderRadius.circular(4.0),
                          borderColor: bgColorOrganizationsAppBar,
                          borderWidth: 2,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 53.0, minWidth: 170.0),
                              child: const Center(
                                  child: Text('Организации',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ))),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              isSelectedOrganizations[index] =
                                  !isSelectedOrganizations[index];
                              isSelectedOrganizations[index]
                                  ? loadMarkersOrganizations()
                                  : _markersOrganizations.clear();
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  final Set<Marker> _markersHouses = {};
  final Set<Marker> _markersEvents = {};
  final Set<Marker> _markersPlaces = {};
  final Set<Marker> _markersOrganizations = {};
  final Set<Marker> _markers = {};

  final List<bool> isSelected = [false];
  final List<bool> isSelectedHouses = [false];
  final List<bool> isSelectedEvents = [false];
  final List<bool> isSelectedPlaces = [false];
  final List<bool> isSelectedOrganizations = [false];

// Функция загрузки маркеров домов
  Future loadMarkersHouses() async {
    var jsonData = await rootBundle.loadString('assets/json/houses.json');
    var data = json.decode(jsonData);
    BitmapDescriptor markerHouses = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/pin_house.png',
    );

    data["house"].forEach((item) {
      String comment = item["street"] + ', ' + item["house"];

      _markersHouses.add(
        Marker(
            markerId: MarkerId(item["ID"]),
            position: LatLng((item["latitude"]), (item["longitude"])),
            infoWindow: InfoWindow(
              title: comment,
            ),
            icon: markerHouses),
      );
      setState(() {});
    });
  }

// Функция загрузки маркеров мероприятий
  Future loadMarkersEvents() async {
    var jsonData = await rootBundle.loadString('assets/json/events.json');
    var data = json.decode(jsonData);
    final pinEvent = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(32, 32)),
        'assets/icons/pin_event.png');

    data["event"].forEach((item) {
      String comment = 'Дата: ' + item["date"] + '. Время: ' + item["time"];
      _markersEvents.add(
        Marker(
            markerId: MarkerId(item["ID"]),
            position: LatLng((item["latitude"]), (item["longitude"])),
            infoWindow: InfoWindow(
              title: item["eventName"],
              snippet: comment,
            ),
            icon: pinEvent),
      );
      setState(() {});
    });
  }

// Функция загрузки маркеров пространств
  Future loadMarkersPlaces() async {
    var jsonData = await rootBundle.loadString('assets/json/locations.json');
    var data = json.decode(jsonData);
    final pinPlaces = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(15.0, 15.0)),
        'assets/icons/pin_location.png');

    data["location"].forEach((item) {
      String comment = item["street"] + ', ' + item["house"];
      _markersPlaces.add(
        Marker(
            markerId: MarkerId(item["ID"]),
            position: LatLng((item["latitude"]), (item["longitude"])),
            infoWindow: InfoWindow(
              title: item["name"],
              snippet: comment,
            ),
            icon: pinPlaces),
      );
      setState(() {});
    });
  }

// Функция загрузки маркеров организаций
  Future loadMarkersOrganizations() async {
    var jsonData =
        await rootBundle.loadString('assets/json/organizations.json');
    var data = json.decode(jsonData);
    final pinOrganizations = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(15, 15)),
        'assets/icons/pin_organization.png');

    data["organization"].forEach((item) {
      String comment = item["street"] + ', ' + item["house"];
      _markersOrganizations.add(
        Marker(
            markerId: MarkerId(item["ID"]),
            position: LatLng((item["latitude"]), (item["longitude"])),
            infoWindow: InfoWindow(
              title: item["name"],
              snippet: comment,
            ),
            icon: pinOrganizations),
      );
      setState(() {});
    });
  }
}
