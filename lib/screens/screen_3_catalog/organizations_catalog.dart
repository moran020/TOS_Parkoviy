import 'package:flutter/material.dart';
import 'package:tos_parkoviy_app/components/colors.dart';
import 'package:tos_parkoviy_app/components/organizations_from_json.dart';
import '../../components/organizations_from_json.dart';
import '../../components/class_data_to_map.dart';

// Список организаций
class CatalogOrganizations extends StatelessWidget {
  const CatalogOrganizations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Организации'),
          centerTitle: true,
          backgroundColor: bgColorOrganizationsAppBar,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundimage1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: const CatalogOrganizationsList()));
  }
}

class CatalogOrganizationsList extends StatefulWidget {
  const CatalogOrganizationsList({
    Key? key,
  }) : super(key: key);

  @override
  _CatalogOrganizationsListState createState() =>
      _CatalogOrganizationsListState();
}

class _CatalogOrganizationsListState extends State<CatalogOrganizationsList> {
  final _searchController = TextEditingController();
  String searchString = "";

  late Future<Organizations> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getOrganizationsList();
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
                    onPressed: () {},
                  ),
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
                var organizations = data.data as Organizations;
                var items = organizations.organization as List<Organization>;

                return ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 15, top: 20, right: 15, bottom: 15),
                  // ignore: unnecessary_null_comparison
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (_, index) {
                    return items[index]
                                .name!
                                .toLowerCase()
                                .contains(searchString) ||
                            items[index]
                                .type!
                                .toLowerCase()
                                .contains(searchString) ||
                            items[index]
                                .shortDescr!
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
                              // Карточка организации
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
                                          color: bgColorOrganizations,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              items[index]
                                                  .abbreviation
                                                  .toString(),
                                              height: 40,
                                              width: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 215,
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 15, bottom: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items[index].name.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.clip),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              items[index]
                                                  .shortDescr
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              overflow: TextOverflow.clip,
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
                                      context, '/organization_card_details',
                                      arguments: DataToMap(
                                        bgcolor: bgColorOrganizationsAppBar,
                                        organizationName: items[index].name,
                                        organizationType: items[index].type,
                                        organizationShortDescr:
                                            items[index].shortDescr,
                                        organizationLongDescr:
                                            items[index].longDescr,
                                        organizationStreet: items[index].street,
                                        organizationHouse: items[index].house,
                                        organizationLongitude:
                                            items[index].longitude,
                                        organizationLatitude:
                                            items[index].latitude,
                                        organizationImage: items[index].image,
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
