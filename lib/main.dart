import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/screens/screen_3_catalog/events_catalog.dart';
import 'package:tos_parkoviy_app/screens/screen_3_catalog/locations_catalog.dart';
import 'package:tos_parkoviy_app/screens/screen_3_catalog/organizations_catalog.dart';
import 'package:tos_parkoviy_app/screens/screen_4_card_details/events_card_details.dart';
import 'package:tos_parkoviy_app/screens/screen_4_card_details/houses_card_details.dart';
import 'package:tos_parkoviy_app/screens/screen_3_catalog/houses_catalog.dart';
import 'package:tos_parkoviy_app/screens/screen_4_card_details/locations_card_details.dart';
import 'package:tos_parkoviy_app/screens/screen_4_card_details/organizations_card_details.dart';
import 'package:tos_parkoviy_app/screens/screen_5_map/houses_map.dart';
import 'package:tos_parkoviy_app/screens/screen_5_map/events_map.dart';
import 'package:tos_parkoviy_app/screens/screen_5_map/locations_map.dart';
import 'package:tos_parkoviy_app/screens/screen_5_map/organizations_map.dart';
import 'package:tos_parkoviy_app/screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const HomeScreen(),
        '/catalog_houses': (context) => const CatalogHouses(),
        '/catalog_events': (context) => const CatalogEvents(),
        '/catalog_locations': (context) => const CatalogLocations(),
        '/catalog_organizations': (context) => const CatalogOrganizations(),
        '/house_card_details': (context) => const HousesCardDetails(),
        '/event_card_details': (context) => const EventsCardDetails(),
        '/location_card_details': (context) => const LocationsCardDetails(),
        '/organization_card_details': (context) =>
            const OrganizationsCardDetails(),
        '/house_map': (context) => const HouseMap(),
        '/event_map': (context) => const EventMap(),
        '/organization_map': (context) => const OrganizationMap(),
        '/location_map': (context) => const LocationMap(),
      },
      debugShowCheckedModeBanner: false,
      title: 'ТОС Парковый',
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          ),
          textTheme: const TextTheme(
            caption: TextStyle(fontSize: 20, color: Colors.white),
          ),
          fontFamily: 'Lato'),
      home: const SplashScreenPage(),
    );
  }
}
