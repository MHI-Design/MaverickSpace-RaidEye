import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uygulama/bluetooth/ble_controller.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage>
    with AutomaticKeepAliveClientMixin<MapViewPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double enlem = 41.227011856131725;
    double boylam = 36.45075436871915;
    double mesafe = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 55),
            Text(
              'RAID EYE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'MontserratAlt1',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GetBuilder<BleController>(
          init: BleController(),
          builder: (controller) {
            return StreamBuilder(
                stream: controller.dataStream,
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      final List<String> verilerim = snapshot.data!.split(',');
                      enlem = double.parse(verilerim[5]);
                      boylam = double.parse(verilerim[6]);
                      mesafe = double.parse(verilerim[8]);
                    }
                    return FlutterMap(
                      options: const MapOptions(
                        initialCenter:
                            LatLng(41.27970152635505, 36.343803418020634),
                        initialZoom: 12,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(enlem, boylam),
                              width: 80,
                              height: 80,
                              child: Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColorDark,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                        CircleLayer(circles: [
                          CircleMarker(
                            point: LatLng(enlem, boylam),
                            color: mesafe < 2
                                ? Colors.red.withOpacity(0.3)
                                : mesafe < 3
                                    ? Colors.yellow.withOpacity(0.3)
                                    : mesafe < 4
                                        ? Colors.green.withOpacity(0.3)
                                        : Colors.blue.withOpacity(0.3),
                            borderStrokeWidth: 3.0,
                            borderColor: Colors.blue,
                            radius: mesafe * 25, //radius
                          )
                        ]),
                      ],
                    );
                  } catch (e) {
                    return FlutterMap(
                      options: const MapOptions(
                        initialCenter:
                            LatLng(41.27970152635505, 36.343803418020634),
                        initialZoom: 12,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                      ],
                    );
                  }
                });
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
