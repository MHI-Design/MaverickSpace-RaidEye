import "package:flutter/material.dart";
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:uygulama/bluetooth/ble_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

import '../models/veri_model.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>
    with AutomaticKeepAliveClientMixin<DataPage> {
  bool isRecording = false;

  List<List<String>> veriListe = [];
  List<String> header = [
    'Sure',
    'Irtifa',
    'Gps Irtifa',
    'Enlem',
    'Boylam',
    'Aci',
    'Durum',
    'Sicaklik',
    'Nem',
    'Gyro X',
    'Gyro Y',
    'Gyro Z',
    'Ivme X',
    'Ivme Y',
    'Ivme Z',
  ];

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });
    if (isRecording) {
      // var now = DateTime.now();
      // var formatterDate = DateFormat('ddMMyy');
      // var formatterTime = DateFormat('kkmmss');
      // String tarih = formatterDate.format(now);
      // String zaman = formatterTime.format(now);
      //final File dosya = File('${tarih}_${zaman}_veri.csv');
    } else {
      exportCSV.myCSV(header, veriListe);
      veriListe.clear();
    }
  }

  List<List<LiveData>> chartData = [];
  List<LiveData> chartData1 = [LiveData(0, 0)];
  List<LiveData> chartData2 = [LiveData(0, 0)];
  List<LiveData> chartData3 = [LiveData(0, 0)];
  List<LiveData> chartData4 = [LiveData(0, 0)];
  List<LiveData> chartData5 = [LiveData(0, 0)];
  List<LiveData> chartData6 = [LiveData(0, 0)];
  List<LiveData> chartData7 = [LiveData(0, 0)];
  List<LiveData> chartData8 = [LiveData(0, 0)];
  List<LiveData> chartData9 = [LiveData(0, 0)];
  List<LiveData> chartData10 = [LiveData(0, 0)];
  List<LiveData> chartData11 = [LiveData(0, 0)];
  ChartSeriesController? _chartSeriesController1;
  ChartSeriesController? _chartSeriesController2;
  ChartSeriesController? _chartSeriesController3;
  ChartSeriesController? _chartSeriesController4;
  ChartSeriesController? _chartSeriesController5;
  ChartSeriesController? _chartSeriesController6;
  ChartSeriesController? _chartSeriesController7;
  ChartSeriesController? _chartSeriesController8;
  ChartSeriesController? _chartSeriesController9;
  ChartSeriesController? _chartSeriesController10;
  ChartSeriesController? _chartSeriesController11;
  List<dynamic>? chartSeriesController = [];
  num time = 19;
  num time2 = 19;
  num zaman = 19;

  Veri veri = Veri(
      'Bağlanmadı', 0, '0', '0', 'Tehdit Yok', 0, 0, 0, 0, 0, 0, '0', '0', 0);
  Veri veriMax = Veri(
      'Bağlanmadı', 0, '0', '0', 'Tehdit Yok', 0, 0, 0, 0, 0, 0, '0', '0', 0);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    chartSeriesController = <dynamic>[
      _chartSeriesController1,
      _chartSeriesController2,
      _chartSeriesController3,
      _chartSeriesController4,
      _chartSeriesController5,
      _chartSeriesController6,
      _chartSeriesController7,
      _chartSeriesController8,
      _chartSeriesController9,
      _chartSeriesController10,
      _chartSeriesController11
    ];

    chartData = <List<LiveData>>[
      chartData1,
      chartData2,
      chartData3,
      chartData4,
      chartData5,
      chartData6,
      chartData7,
      chartData8,
      chartData9,
      chartData10,
      chartData11
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        actions: [
          Text(isRecording ? 'Bitir' : 'Kayıt'),
          IconButton(
            icon: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
            onPressed: toggleRecording,
            color: isRecording ? Colors.red : Colors.green,
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GetBuilder<BleController>(
          init: BleController(),
          builder: (controller) {
            return StreamBuilder(
                stream: controller.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    try {
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
                      veri.sure = double.parse(verilerim[13]);

                      if (isRecording) {
                        List<String> data = [
                          veri.durum.toString(),
                          veri.service_uuid.toString(),
                          veri.characteristic_uuid.toString(),
                          veri.tehdit.toString(),
                          veri.enlem.toString(),
                          veri.boylam.toString(),
                          veri.irtifa.toString(),
                          veri.mesafe.toString(),
                          veri.hiz.toString(),
                          veri.sinyal.toString(),
                          veri.frekans.toString(),
                          veri.yonelim.toString(),
                          veri.sure.toString(),
                        ];
                        veriListe.add(data);
                      }

                      if (veri.irtifa > veriMax.irtifa) {
                        veriMax.irtifa = veri.irtifa;
                      }
                      if (veri.hiz > veriMax.hiz) {
                        veriMax.hiz = veri.hiz;
                      }

                      try {
                        chartData[0].add(LiveData(veri.sure, veri.irtifa));
                        if (chartData[0].length > 600) {
                          chartData[0].removeAt(0);
                          chartSeriesController?[0].updateDataSource(
                            addedDataIndex: chartData[0].length - 1,
                            removedDataIndex: 0,
                          );
                        } else {
                          chartSeriesController?[0].updateDataSource(
                            addedDataIndex: chartData[0].length,
                          );
                        }
                      } catch (e) {
                        print('chartseriescontroller index 0 hata $e');
                      }

                      try {
                        chartData[1].add(LiveData(veri.sure, veri.hiz));
                        if (chartData[1].length > 600) {
                          chartData[1].removeAt(0);
                          chartSeriesController?[1].updateDataSource(
                            addedDataIndex: chartData[1].length - 1,
                            removedDataIndex: 0,
                          );
                        } else {
                          chartSeriesController?[1].updateDataSource(
                            addedDataIndex: chartData[1].length,
                          );
                        }
                      } catch (e) {
                        print('chartseriescontroller index 1 hata $e');
                      }
                    } catch (e) {
                      chartData[0] = [LiveData(0, 0)];
                      chartData[1] = [LiveData(0, 0)];
                      chartData[2] = [LiveData(0, 0)];
                      chartData[3] = [LiveData(0, 0)];
                      chartData[4] = [LiveData(0, 0)];
                      chartData[5] = [LiveData(0, 0)];
                      chartData[6] = [LiveData(0, 0)];
                      chartData[7] = [LiveData(0, 0)];
                      chartData[8] = [LiveData(0, 0)];
                      chartData[9] = [LiveData(0, 0)];
                      chartData[10] = [LiveData(0, 0)];
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children: [
                        VeriWidget(
                            baslik: 'İRTİFA',
                            altBaslik: 'Basınca Bağlı İrtifa (m)',
                            deger: veri.irtifa,
                            maksimumDeger: veriMax.irtifa,
                            child: buildLiveChart(0)),
                        VeriWidget(
                            baslik: 'HIZ',
                            altBaslik: 'Yaklaşan drone hızı (m/s)',
                            deger: veri.hiz,
                            maksimumDeger: veriMax.hiz,
                            child: buildLiveChart(1)),
                      ],
                    );
                  } else {
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                    child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_right_sharp,
                                      size: 40,
                                    ),
                                    Text(
                                      veri.tehdit,
                                      style: TextStyle(
                                          color: veri.tehdit == 'Tehdit Yok'
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                  ],
                                )),
                              ),
                              //const Expanded(child: SizedBox(width: 10)),
                              Expanded(
                                child: Card(
                                  child: Row(
                                    children: [
                                      Text(
                                        veri.durum,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 28),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.location_on_outlined, size: 48),
                            ),
                            title: const Text('Enlem',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.enlem.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.location_on_outlined, size: 48),
                            ),
                            title: const Text('Boylam',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.boylam.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                                width: 75, child: Icon(Icons.height, size: 48)),
                            title: const Text('İrtifa',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.irtifa.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.arrow_forward, size: 48),
                            ),
                            title: const Text('Mesafe',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.mesafe.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.speed, size: 48),
                            ),
                            title: const Text('Hız',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.hiz.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.signal_cellular_alt, size: 48),
                            ),
                            title: const Text('Sinyal Gücü',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.sinyal.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const SizedBox(
                              width: 75,
                              child: Icon(Icons.directions, size: 48),
                            ),
                            title: const Text('Yönelim',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            subtitle: Text(
                              veri.yonelim.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                'Frekans Spektrumu',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              Expanded(child: SizedBox(width: 10)),
                              Text(
                                'Signal Level',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '5.8 GHz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Expanded(child: SizedBox(width: 10)),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '2.4 GHz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Expanded(child: SizedBox(width: 10)),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '1.3 GHz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Expanded(child: SizedBox(width: 10)),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '900 MHz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Expanded(child: SizedBox(width: 10)),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '433 MHz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Expanded(child: SizedBox(width: 10)),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        VeriWidget(
                            baslik: 'İRTİFA',
                            altBaslik: 'Basınca Bağlı İrtifa (m)',
                            child: buildLiveChart(0)),
                        VeriWidget(
                            baslik: 'HIZ',
                            altBaslik: 'Yaklaşan Cismin Hızı (m/s)',
                            child: buildLiveChart(1)),
                      ],
                    );
                  }
                });
          }),
    );
  }

  SfCartesianChart buildLiveChart(int i) {
    return SfCartesianChart(
      series: <LineSeries<LiveData, num>>[
        LineSeries<LiveData, num>(
          onRendererCreated: (ChartSeriesController controller) {
            chartSeriesController![i] = controller;
          },
          dataSource: chartData[i],
          color: Theme.of(context)
              .primaryColorDark, //const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (LiveData veri, _) => veri.time,
          yValueMapper: (LiveData veri, _) => veri.value,
        )
      ],
      primaryXAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 5,
        //title: AxisTitle(text: 'Zaman (s)'),
      ),
      primaryYAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        //title: AxisTitle(text: 'Veri Değer'),
      ),
    );
  }

  void updateDataSource(Timer timer) {
    chartData1
        .add(LiveData((time = time + 1), (math.Random().nextInt(60) + 30)));
    chartData1.removeAt(0);
    _chartSeriesController1?.updateDataSource(
      addedDataIndex: chartData1.length - 1,
      removedDataIndex: 0,
    );
    chartData2
        .add(LiveData((time2 = time2 + 1), (math.Random().nextInt(60) + 30)));
    chartData2.removeAt(0);
    _chartSeriesController2?.updateDataSource(
      addedDataIndex: chartData2.length - 1,
      removedDataIndex: 0,
    );
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
    ];
  }
}

class VeriWidget extends StatefulWidget {
  const VeriWidget({
    super.key,
    required this.child,
    this.baslik = 'baslik',
    this.altBaslik = 'altBaslik',
    this.maksimumDeger = 0,
    this.deger = 0,
  });

  final String altBaslik;
  final String baslik;
  final Widget child;
  final double maksimumDeger;
  final double deger;

  @override
  State<VeriWidget> createState() => _VeriWidgetState();
}

class _VeriWidgetState extends State<VeriWidget> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatterDate = DateFormat('dd-MM-yy');
    var formatterTime = DateFormat('kk:mm:ss');
    String tarih = formatterDate.format(now);
    String zaman = formatterTime.format(now);
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_right_sharp,
                //color: Colors.white,
                size: 40,
              ),
              Text(widget.baslik,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28)),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.altBaslik,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const Expanded(child: SizedBox(width: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(tarih, style: const TextStyle(fontSize: 12)),
                    Text(zaman, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: widget.child, //buildLiveChart(),
                ),
                const VerticalDivider(width: 0),
                Expanded(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox(height: 1)),
                      const Text('Değer'),
                      Text(widget.deger.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).primaryColorDark)),
                      const Expanded(child: Divider()),
                      const Text('Max'),
                      Text(widget.maksimumDeger.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).primaryColorDark)),
                      const Expanded(child: SizedBox(height: 1)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.value);
  final num time;
  final num value;
}
