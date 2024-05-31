import 'dart:async';

import "package:flutter/material.dart";
import 'package:uygulama/pages/settings_page.dart';
import 'dart:ui';
import 'package:uygulama/models/veri_model.dart';
import 'package:uygulama/bluetooth/ble_controller.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  late Veri veri = Veri(
      'Bağlanmadı', 0, '0', '0', 'Tehdit Yok', 0, 0, 0, 0, 0, 0, '0', '0', 0);
  Map<String, dynamic> veriMap = {
    'Durum': 'Bağlanmadı',
    'Cihaz ID': 000,
    'Service UUID': 'AAAAAAAA-0000-BBBB-FF00-0000AAAABBBBCCCC',
    'Characteristic UUID': 'AAAAAAAA-0000-BBBB-FF00-0000AAAABBBBCCCC',
    'Tehdit': 'Yok',
    'Enlem': 0,
    'Boylam': 0,
    'İrtifa': 0,
    'Mesafe': 0,
    'Hız': 0,
    'Sinyal Gücü': 0,
    'Frekans': '5.800',
    'Yönelim': '0',
  };
  final List veriIconListe = [
    Icons.bluetooth,
    Icons.perm_identity,
    Icons.home_repair_service,
    Icons.message,
  ];
  late var conn;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.sizeOf(context);

    bool isMtuChanged = false;

    return GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) {
          // if (controller.esp32Device != null) {
          //   controller.esp32Device!.requestMtu(256);
          // }
          return StreamBuilder(
              stream: controller.dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    if (isMtuChanged == false) {
                      controller.esp32Device!.requestMtu(256);
                      isMtuChanged = true;
                    }
                    //controller.esp32Device!.requestMtu(256);
                    final List<String> verilerim = snapshot.data!.split(',');
                    veri.durum = verilerim[0];
                    veri.id = double.parse(verilerim[1]);
                    veri.service_uuid = verilerim[2];
                    veri.characteristic_uuid = verilerim[3];
                    veri.tehdit = verilerim[4];
                    veri.enlem = double.parse(verilerim[5]);
                    veri.boylam = double.parse(verilerim[6]);
                    veri.irtifa = double.parse(verilerim[7]);
                    veri.mesafe = double.parse(verilerim[8]);
                    veri.hiz = double.parse(verilerim[9]);
                    veri.sinyal = double.parse(verilerim[10]);
                    veri.frekans = verilerim[11];
                    veri.yonelim = verilerim[12];
                    veriMap['Durum'] = veri.durum;
                    veriMap['Cihaz ID'] = veri.id;
                    veriMap['Service UUID'] = veri.service_uuid;
                    veriMap['Characteristic UUID'] = veri.characteristic_uuid;
                    veriMap['Tehdit'] = veri.tehdit;
                    veriMap['Enlem'] = veri.enlem;
                    veriMap['Boylam'] = veri.boylam;
                    veriMap['İrtifa'] = veri.irtifa;
                    veriMap['Mesafe'] = veri.mesafe;
                    veriMap['Hız'] = veri.hiz;
                    veriMap['Sinyal Gücü'] = veri.sinyal;
                    veriMap['Frekans'] = veri.frekans;
                    veriMap['Yönelim'] = veri.yonelim;
                    return CustomScrollView(
                      slivers: <Widget>[
                        //2
                        MySliverAppBar(size: size),
                        //3
                        MySliverList(
                            veriMap: veriMap, veriIcons: veriIconListe),
                      ],
                    );
                  } catch (e) {
                    isMtuChanged = false;
                    return CustomScrollView(
                      slivers: [
                        MySliverAppBar(size: size),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, int index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        controller.startReadingData();
                                      },
                                      child: const Text(
                                        'BAĞLAN',
                                        style: TextStyle(fontSize: 36),
                                      )),
                                );
                              } else if (index < veriMap.length + 1) {
                                return ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(16),
                                    //width: 100,
                                    //height: 200,
                                    child: const CircularProgressIndicator(),
                                  ),
                                  title: Text(
                                      '${veriMap.keys.elementAt(index - 1)}: ',
                                      style: const TextStyle(fontSize: 48)),
                                  subtitle: Text(
                                      '${veriMap.values.elementAt(index - 1)}',
                                      style: const TextStyle(fontSize: 32)),
                                );
                              } else {
                                return SafeArea(child: Container());
                              }
                            },
                            childCount: veriMap.length + 2,
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return CustomScrollView(
                    slivers: [
                      MySliverAppBar(size: size),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.startScanningAndConnecting();
                                    },
                                    child: const Text(
                                      'BAĞLAN',
                                      style: TextStyle(fontSize: 24),
                                    )),
                              );
                            } else if (index < 5) {
                              return ListTile(
                                //contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 100,
                                  height: 200,
                                  child: Icon(veriIconListe[index - 1]),
                                ),
                                title: Text(
                                    '${veriMap.keys.elementAt(index - 1)}: ',
                                    style: const TextStyle(fontSize: 32)),
                                subtitle: Text(
                                    '${veriMap.values.elementAt(index - 1)}',
                                    style: const TextStyle(fontSize: 24)),
                              );
                            } else {
                              return SafeArea(child: Container());
                            }
                          },
                          childCount: veriMap.length + 2,
                        ),
                      ),
                    ],
                  );
                }
              });
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MySliverList extends StatelessWidget {
  const MySliverList({
    super.key,
    required this.veriMap,
    required this.veriIcons,
  });

  final Map<String, dynamic> veriMap;

  final List veriIcons;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          if (index != veriMap.length) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                height: 200,
                child: Icon(veriIcons[index]),
              ),
              title: Text('${veriMap.keys.elementAt(index)}: ',
                  style: const TextStyle(fontSize: 32)),
              subtitle: Text('${veriMap.values.elementAt(index)}',
                  style: const TextStyle(fontSize: 24)),
            );
          } else {
            return SafeArea(child: Container());
          }
        },
        childCount: veriMap.length + 1,
      ),
    );
  }
}

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: size.height / 2,
      pinned: true,
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      title: const Row(
        children: [
          SizedBox(width: 20),
        ],
      ),
      surfaceTintColor: Theme.of(context).primaryColor,
      //forceElevated: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        //title: Image.asset('assets/images/title.png', width: 150),
        title: const Text(
          'RAID EYE',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'MontserratAlt1',
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(60)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/drone.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          iconSize: 32,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
          icon: const Icon(Icons.settings),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
