import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;

  BluetoothDevice? esp32Device;

  late BluetoothCharacteristic _characteristic;

  final _dataStreamController = StreamController<String>.broadcast();

  Stream<String> get dataStream => _dataStreamController.stream;

  Future<void> startScanningAndConnecting() async {
    flutterBlue.startScan(timeout: Duration(seconds: 10));

    flutterBlue.scanResults.listen((List<ScanResult> results) async {
      for (ScanResult result in results) {
        if (result.device.name == "Raid Eye") {
          flutterBlue.stopScan();

          await connectToEsp32(result.device);

          startReadingData();

          //esp32Device!.requestMtu(128);
        }
      }
    });
  }

  Future<void> connectToEsp32(BluetoothDevice device) async {
    try {
      await device.connect();

      esp32Device = device;

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString().toUpperCase() ==
              "BEB5483E-36E1-4688-B7F5-EA07361B26A8") {
            _characteristic = characteristic;
            break;
          }
        }
      }
      print("Bağlandı");
      startReadingData();

      device.state.listen((BluetoothDeviceState state) {
        if (state == BluetoothDeviceState.disconnected) {
          print("Bağlantı Kesildi");

          connectToEsp32(device);

          startReadingData();
        }
      });
    } catch (e) {
      print("Connection error: $e");
    }
  }

  void startReadingData() async {
    if (esp32Device != null) {
      await _characteristic.setNotifyValue(true);
      _characteristic.value.listen((List<int>? value) {
        if (value != null) {
          String stringValue = String.fromCharCodes(value);
          print("Veriler: $stringValue");

          _dataStreamController.sink.add(stringValue);
        }
      });
    }
  }

  Future<void> disconnectEsp32() async {
    if (esp32Device != null) {
      await esp32Device!.disconnect();
      esp32Device = null;
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      update();
    } catch (e) {
      print('Bağlantı hatası: $e');
    }
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      connectedDevice = null;
      update();
    }
  }

  Future<void> readDataFromDevice() async {
    if (connectedDevice != null) {
      try {
        List<BluetoothService> services =
            await connectedDevice!.discoverServices();
        for (BluetoothService service in services) {
          if (service.uuid.toString().toUpperCase() ==
              "4FAFC201-1FB5-459E-8FCC-C5C9C331914B") {
            List<BluetoothCharacteristic> characteristics =
                service.characteristics;
            for (BluetoothCharacteristic characteristic in characteristics) {
              if (characteristic.uuid.toString().toUpperCase() ==
                  "BEB5483E-36E1-4688-B7F5-EA07361B26A8") {
                List<int> value = await characteristic.read();

                print('Read data: $value');

                String stringValue = utf8.decode(value);

                print('Read data: $stringValue');

                _dataStreamController.add(stringValue);

                await Future.delayed(const Duration(seconds: 1));
              }
            }
          }
        }
      } catch (e) {
        print('Veri okuma hatası: $e');
      }
    } else {
      print('Cihaz bağlı değil. Lütfen cihazı bağlayın.');
    }
  }

  Future scanDevices() async {
    var blePermission = await Permission.bluetoothScan.status;
    if (blePermission.isDenied) {
      if (await Permission.bluetoothScan.request().isGranted) {
        if (await Permission.bluetoothConnect.request().isGranted) {
          flutterBlue.startScan(timeout: const Duration(seconds: 10));
        }
      }
    } else {
      flutterBlue.startScan(timeout: const Duration(seconds: 10));
    }

    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {}
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
