import 'package:flutter/material.dart';
import '../components/colors.dart';
import 'package:tos_parkoviy_app/screens/tos_map.dart';

// Главное меню
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/backgroundimage.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7),
                BlendMode.colorDodge,
              )),
        ),
        child: const Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  hexColor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Выберите раздел',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(hexColor('#00365B')),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const MenuCard(
            icon: 'assets/icons/houses.png',
            bgcolor: bgColorHousesAppBar,
            title: 'Дома',
            pathName: '/catalog_houses',
          ),
          const MenuCard(
            icon: 'assets/icons/events.png',
            bgcolor: bgColorEventsAppBar,
            title: 'Мероприятия',
            pathName: '/catalog_events',
          ),
          const MenuCard(
            icon: 'assets/icons/locations.png',
            bgcolor: bgColorPlacesAppBar,
            title: 'Пространства',
            pathName: '/catalog_locations',
          ),
          const MenuCard(
            icon: 'assets/icons/organizations.png',
            bgcolor: bgColorOrganizationsAppBar,
            title: 'Организации',
            pathName: '/catalog_organizations',
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: ButtonStyleButton.allOrNull(20.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150))),
                backgroundColor:
                    MaterialStateProperty.all<Color>(bgColorMapAppBar),
              ),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: ((context) => const TOSMap()));
                Navigator.push(context, route);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/map.png',
                    width: 60,
                    height: 70,
                  ),
                  const SizedBox(width: 25),
                  const Expanded(
                    child: Text(
                      'Карта локаций',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

// Конструктор для разделов главного меню
class MenuCard extends StatelessWidget {
  final String icon;
  final String title;
  final String pathName;
  final dynamic bgcolor;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.bgcolor,
    required this.title,
    required this.pathName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: ButtonStyleButton.allOrNull(20.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(150))),
          backgroundColor: MaterialStateProperty.all<Color>(bgcolor),
        ),
        onPressed: () {
          {
            Navigator.pushNamed(
              context,
              pathName,
            );
          }
        },
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 25),
            Text(
              title,
              style: const TextStyle(fontSize: 23, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
