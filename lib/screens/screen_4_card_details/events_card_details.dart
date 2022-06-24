import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:tos_parkoviy_app/components/class_data_to_map.dart';

// Страница выбранного мероприятия
class EventsCardDetails extends StatefulWidget {
  const EventsCardDetails({Key? key}) : super(key: key);

  @override
  State<EventsCardDetails> createState() => _EventsCardDetailsState();
}

class _EventsCardDetailsState extends State<EventsCardDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataToMap;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Мероприятие'),
          centerTitle: true,
          backgroundColor: bgColorEventsAppBar,
          // Передача данных о мероприятии на страницу с картой
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.pin_drop_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/event_map',
                    arguments: DataToMap(
                      bgcolor: args.bgcolor,
                      whatIsThis: "event",
                      eventName: args.eventName,
                      eventPlace: args.eventPlace,
                      eventLongitude: args.eventLongitude,
                      eventLatitude: args.eventLatitude,
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
                      // Название мероприятия
                      Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Text(
                            args.eventName,
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
                          // Таблица с данными о мероприятии
                          child: Table(
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 15, 0, 2),
                                      child: const Text(
                                        'Место проведения',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 2),
                                      child: Text(
                                        args.eventPlace,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 2, 0, 15),
                                      child: const Text(
                                        'Дата и время',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 2, 0, 15),
                                      child: Text(
                                        args.eventDate + " " + args.eventTime,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 7),
                      // Изображение
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(args.eventImg),
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
                                  child: Text(args.eventDesc,
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
