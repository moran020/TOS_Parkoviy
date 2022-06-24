import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:tos_parkoviy_app/components/class_data_to_map.dart';

// Страница выбранной организации
class OrganizationsCardDetails extends StatefulWidget {
  const OrganizationsCardDetails({Key? key}) : super(key: key);

  @override
  State<OrganizationsCardDetails> createState() =>
      _OrganizationsCardDetailsState();
}

class _OrganizationsCardDetailsState extends State<OrganizationsCardDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataToMap;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Организация'),
          centerTitle: true,
          backgroundColor: bgColorOrganizationsAppBar,
          // Передача данных об организации на страницу с картой
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.pin_drop_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/organization_map',
                    arguments: DataToMap(
                      bgcolor: args.bgcolor,
                      whatIsThis: "organization",
                      organizationName: args.organizationName,
                      organizationStreet: args.organizationStreet,
                      organizationHouse: args.organizationHouse,
                      organizationLatitude: args.organizationLatitude,
                      organizationLongitude: args.organizationLongitude,
                    ));
              },
            ),
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/backgroundimage2.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.65),
                  BlendMode.colorDodge,
                ),
              ),
            ),
            child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      // Название организации
                      Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Text(
                            args.organizationName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(height: 7),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          // Таблица с данными об организации
                          child: Table(
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 15, 0, 2),
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Адрес',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 2),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            args.organizationStreet +
                                                ", " +
                                                args.organizationHouse,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ))),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 2, 0, 15),
                                      child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Тип организации',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 2, 0, 15),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            args.organizationType,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ))),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 7),
                      // Изображение
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(args.organizationImage),
                      ),
                      const SizedBox(height: 7),
                      // Полное описание
                      Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(args.organizationLongDescr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.clip)),
                            ],
                          )),
                      const SizedBox(height: 7),
                    ])))));
  }
}
