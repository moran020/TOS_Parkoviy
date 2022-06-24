import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:tos_parkoviy_app/components/class_data_to_map.dart';

// Страница выбранного дома
class HousesCardDetails extends StatefulWidget {
  const HousesCardDetails({Key? key}) : super(key: key);

  @override
  State<HousesCardDetails> createState() => _HousesCardDetailsState();
}

class _HousesCardDetailsState extends State<HousesCardDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataToMap;

    return Scaffold(
        appBar: AppBar(
          title: Text(args.streetHouse + ", " + args.numberHouse),
          centerTitle: true,
          backgroundColor: args.bgcolor,
          // Передача данных о доме на страницу с картой
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.pin_drop_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/house_map',
                    arguments: DataToMap(
                      bgcolor: args.bgcolor,
                      whatIsThis: "house",
                      streetHouse: args.streetHouse,
                      numberHouse: args.numberHouse,
                      houseLongitude: args.houseLongitude,
                      houseLatitude: args.houseLatitude,
                    ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(children: [
                  const SectionName(
                    title: 'Старший',
                  ),
                  const SizedBox(height: 7),
                  // Получение данных о старшем из предыдущего раздела
                  Caretaker(
                    name: args.caretakerName,
                    dadname: args.caretakerDadname,
                    surname: args.caretakerSurname,
                    contact: args.caretakerContact,
                  ),
                  const SizedBox(height: 7),
                  const SectionName(
                    title: 'Информация о доме',
                  ),
                  const SizedBox(height: 7),
                  // Получение информации о доме из предыдущего раздела
                  Information(
                    year: args.houseYear,
                    serviceProvider: args.serviceProvider,
                  ),
                  const SizedBox(height: 7),
                  const SectionName(
                    title: 'Капитальный ремонт',
                  ),
                  const SizedBox(height: 7),
                  // Получение информации о капремонте из предыдущего раздела
                  Refurbishment(
                    refurbishmentRoofYear: args.refurbishmentRoofYear,
                    refurbishmentRoofCondition: args.refurbishmentRoofCondition,
                    refurbishmentFrontYear: args.refurbishmentFrontYear,
                    refurbishmentFrontCondition:
                        args.refurbishmentFrontCondition,
                    refurbishmentElectronicsYear:
                        args.refurbishmentElectronicsYear,
                    refurbishmentElectronicsCondition:
                        args.refurbishmentElectronicsCondition,
                    refurbishmentWaterYear: args.refurbishmentWaterYear,
                    refurbishmentWaterCondition:
                        args.refurbishmentWaterCondition,
                    refurbishmentSewerageYear: args.refurbishmentSewerageYear,
                    refurbishmentSewerageCondition:
                        args.refurbishmentSewerageCondition,
                    refurbishmentHeatingYear: args.refurbishmentHeatingYear,
                    refurbishmentHeatingCondition:
                        args.refurbishmentHeatingCondition,
                    refurbishmentGasYear: args.refurbishmentGasYear,
                    refurbishmentGasCondition: args.refurbishmentGasCondition,
                  ),
                ]))));
  }
}

// Раздел "Старший"
class Caretaker extends StatelessWidget {
  final String? name;
  final String? surname;
  final String? dadname;
  final String? contact;

  const Caretaker({
    Key? key,
    this.name,
    this.surname,
    this.dadname,
    this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Row(children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/default_photo.png',
                    height: 90,
                    width: 90,
                  ))),
          SizedBox(
              width: 230,
              child: Table(
                columnWidths: const {0: FlexColumnWidth(0.65)},
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: const Text(
                            'Имя',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Text(
                            name.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: const Text(
                            'Отчество',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Text(
                            dadname.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: const Text(
                            'Фамилия',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Text(
                            surname.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: const Text(
                            'Контакт',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Text(
                            contact.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ],
              ))
        ]));
  }
}

// Раздел "Информация о доме"
class Information extends StatelessWidget {
  final int? year;
  final String? serviceProvider;

  const Information({
    Key? key,
    this.year,
    this.serviceProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Table(
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    child: const Text(
                      'Год постройки',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                      year.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
            TableRow(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    child: const Text(
                      'УК',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                      serviceProvider.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ],
        ));
  }
}

// Раздел "Капремонт"
class Refurbishment extends StatelessWidget {
  final int? refurbishmentRoofYear;
  final bool? refurbishmentRoofCondition;
  final int? refurbishmentFrontYear;
  final bool? refurbishmentFrontCondition;
  final int? refurbishmentElectronicsYear;
  final bool? refurbishmentElectronicsCondition;
  final int? refurbishmentWaterYear;
  final bool? refurbishmentWaterCondition;
  final int? refurbishmentSewerageYear;
  final bool? refurbishmentSewerageCondition;
  final int? refurbishmentHeatingYear;
  final bool? refurbishmentHeatingCondition;
  final int? refurbishmentGasYear;
  final bool? refurbishmentGasCondition;

  const Refurbishment({
    Key? key,
    this.refurbishmentRoofYear,
    this.refurbishmentRoofCondition,
    this.refurbishmentFrontYear,
    this.refurbishmentFrontCondition,
    this.refurbishmentElectronicsYear,
    this.refurbishmentElectronicsCondition,
    this.refurbishmentWaterYear,
    this.refurbishmentWaterCondition,
    this.refurbishmentSewerageYear,
    this.refurbishmentSewerageCondition,
    this.refurbishmentHeatingYear,
    this.refurbishmentHeatingCondition,
    this.refurbishmentGasYear,
    this.refurbishmentGasCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Table(columnWidths: const {
            0: FlexColumnWidth(0.45),
            1: FlexColumnWidth(0.4),
            2: FlexColumnWidth(0.4),
          }, children: <TableRow>[
            TableRow(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Text(
                      'Вид работ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Text(
                      'Год',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Text(
                      'Статус',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ]),
          RefurbishmentTable(
              title: "Крыша",
              refurbishmentYear: refurbishmentRoofYear,
              refurbishmentCondition: refurbishmentRoofCondition),
          RefurbishmentTable(
              title: "Фасад",
              refurbishmentYear: refurbishmentFrontYear,
              refurbishmentCondition: refurbishmentFrontCondition),
          RefurbishmentTable(
              title: "Электрика",
              refurbishmentYear: refurbishmentElectronicsYear,
              refurbishmentCondition: refurbishmentElectronicsCondition),
          RefurbishmentTable(
              title: "Вода",
              refurbishmentYear: refurbishmentWaterYear,
              refurbishmentCondition: refurbishmentWaterCondition),
          RefurbishmentTable(
              title: "Канализация",
              refurbishmentYear: refurbishmentSewerageYear,
              refurbishmentCondition: refurbishmentSewerageCondition),
          RefurbishmentTable(
              title: "Отопление",
              refurbishmentYear: refurbishmentHeatingYear,
              refurbishmentCondition: refurbishmentHeatingCondition),
          RefurbishmentTable(
              title: "Газ",
              refurbishmentYear: refurbishmentGasYear,
              refurbishmentCondition: refurbishmentGasCondition),
        ]));
  }
}

// Конструктор для каждого вида работ
class RefurbishmentTable extends StatelessWidget {
  final String? title;
  final int? refurbishmentYear;
  final bool? refurbishmentCondition;

  const RefurbishmentTable({
    Key? key,
    this.title,
    this.refurbishmentYear,
    this.refurbishmentCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(columnWidths: const {
      0: FlexColumnWidth(0.45),
      1: FlexColumnWidth(0.4),
      2: FlexColumnWidth(0.4),
    }, children: <TableRow>[
      TableRow(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 2, bottom: 2),
              child: Text(
                title.toString(),
                style: const TextStyle(fontSize: 16),
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 2, bottom: 2),
              child: Text(
                refurbishmentYear.toString(),
                style: const TextStyle(fontSize: 16),
              )),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 2, bottom: 2),
            child: isTrue(refurbishmentCondition)
                ? const Icon(
                    Icons.done,
                    size: 30,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.red,
                  ),
          ),
        ],
      )
    ]);
  }
}

// Определение иконки со статусом капремонта
bool isTrue(bool? a) {
  if (a == null) {
    return false;
  }
  return a;
}

// Конструктор для поля с названием раздела
class SectionName extends StatelessWidget {
  final String? title;

  const SectionName({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColorHouses),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ));
  }
}
