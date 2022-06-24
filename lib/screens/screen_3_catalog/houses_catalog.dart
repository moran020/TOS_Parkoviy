import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:tos_parkoviy_app/components/class_data_to_map.dart';
import '../../components/houses_from_json.dart';

// Список домов
class CatalogHouses extends StatelessWidget {
  const CatalogHouses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Дома'),
          centerTitle: true,
          backgroundColor: bgColorHousesAppBar,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundimage1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const CatalogHousesList()));
  }
}

class CatalogHousesList extends StatefulWidget {
  const CatalogHousesList({
    Key? key,
  }) : super(key: key);

  @override
  _CatalogHousesListState createState() => _CatalogHousesListState();
}

class _CatalogHousesListState extends State<CatalogHousesList> {
  final _searchController = TextEditingController();
  String searchString = "";
  late Future<Houses> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getHousesList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Поле поиска
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding:
                const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 00),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black45,
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Поиск",
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchString = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                ]),
          ),
        ),
        // Список в соответствии с запросом (по умолчанию запрос пустой)
        Expanded(
          child: FutureBuilder(
            future: futureData,
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var houses = data.data as Houses;
                var items = houses.house as List<House>;
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 15, top: 20, right: 15, bottom: 15),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return items[index]
                                .street!
                                .toLowerCase()
                                .contains(searchString) ||
                            items[index]
                                .caretaker![0]
                                .caretakerDadname!
                                .toLowerCase()
                                .contains(searchString) ||
                            items[index]
                                .caretaker![0]
                                .caretakerName!
                                .toLowerCase()
                                .contains(searchString) ||
                            items[index]
                                .caretaker![0]
                                .caretakerSurname!
                                .toLowerCase()
                                .contains(searchString)
                        ? GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              // Карточка дома
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(
                                            right: 18, left: 15),
                                        decoration: const BoxDecoration(
                                          color: bgColorHouses,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              items[index].house.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 15, bottom: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items[index].street.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "Старший: " +
                                                  items[index]
                                                      .caretaker![0]
                                                      .caretakerSurname
                                                      .toString() +
                                                  " " +
                                                  items[index]
                                                      .caretaker![0]
                                                      .initials
                                                      .toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Кнопка перехода в следующий раздел
                                  Column(
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black87,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Передача информации о выбранном доме в следующий раздел
                            onTap: () => {
                                  Navigator.pushNamed(
                                      context, '/house_card_details',
                                      arguments: DataToMap(
                                        bgcolor: bgColorHousesAppBar,
                                        itemId: items[index].iD,
                                        streetHouse: items[index].street,
                                        numberHouse: items[index].house,
                                        caretakerName: items[index]
                                            .caretaker![0]
                                            .caretakerName,
                                        caretakerDadname: items[index]
                                            .caretaker![0]
                                            .caretakerDadname,
                                        caretakerSurname: items[index]
                                            .caretaker![0]
                                            .caretakerSurname,
                                        caretakerContact:
                                            items[index].caretaker![0].contact,
                                        houseYear: items[index].year,
                                        serviceProvider:
                                            items[index].serviceProvider,
                                        refurbishmentRoofYear: items[index]
                                            .refurbishment![0]
                                            .roof![0]
                                            .maintenanceYear,
                                        refurbishmentRoofCondition: items[index]
                                            .refurbishment![0]
                                            .roof![0]
                                            .condition,
                                        refurbishmentFrontYear: items[index]
                                            .refurbishment![0]
                                            .front![0]
                                            .maintenanceYear,
                                        refurbishmentFrontCondition:
                                            items[index]
                                                .refurbishment![0]
                                                .front![0]
                                                .condition,
                                        refurbishmentElectronicsYear:
                                            items[index]
                                                .refurbishment![0]
                                                .electronics![0]
                                                .maintenanceYear,
                                        refurbishmentElectronicsCondition:
                                            items[index]
                                                .refurbishment![0]
                                                .electronics![0]
                                                .condition,
                                        refurbishmentWaterYear: items[index]
                                            .refurbishment![0]
                                            .water![0]
                                            .maintenanceYear,
                                        refurbishmentWaterCondition:
                                            items[index]
                                                .refurbishment![0]
                                                .water![0]
                                                .condition,
                                        refurbishmentSewerageYear: items[index]
                                            .refurbishment![0]
                                            .sewerage![0]
                                            .maintenanceYear,
                                        refurbishmentSewerageCondition:
                                            items[index]
                                                .refurbishment![0]
                                                .sewerage![0]
                                                .condition,
                                        refurbishmentHeatingYear: items[index]
                                            .refurbishment![0]
                                            .heating![0]
                                            .maintenanceYear,
                                        refurbishmentHeatingCondition:
                                            items[index]
                                                .refurbishment![0]
                                                .heating![0]
                                                .condition,
                                        refurbishmentGasYear: items[index]
                                            .refurbishment![0]
                                            .gas![0]
                                            .maintenanceYear,
                                        refurbishmentGasCondition: items[index]
                                            .refurbishment![0]
                                            .gas![0]
                                            .condition,
                                        houseLongitude: items[index].longitude,
                                        houseLatitude: items[index].latitude,
                                      ))
                                })
                        : Container();
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
