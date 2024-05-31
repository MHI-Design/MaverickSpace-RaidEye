import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:uygulama/model_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Ayarlar'),
          ),
          body: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Uygulama Görünümü'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeNotifier.isDark
                              ? "Karanlık Mod"
                              : "Aydınlık Mod",
                          style: const TextStyle(fontSize: 24),
                        ),
                        IconButton(
                            icon: Icon(themeNotifier.isDark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny),
                            onPressed: () {
                              themeNotifier.isDark
                                  ? themeNotifier.isDark = false
                                  : themeNotifier.isDark = true;
                            })
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //const Icon(Icons.arrow_forward_ios),
                        const Text(
                          'Harita Görünümü',
                          style: TextStyle(fontSize: 24),
                        ),
                        IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('İzinler'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListTile(
                      leading: const Icon(Icons.bluetooth),
                      title: const Text('Bluetooth İzni'),
                      subtitle: const Text(
                        'Cihazla iletişim kurmak ve verileri almak için bu izne ihtiyacımız var.',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 12)),
                        child: const Text('İzin verildi'),
                      ),
                      //Icon(Icons.navigate_next),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: const Text('Konum İzni'),
                      subtitle: const Text(
                        'Konumunuzu bulmak ve mesafeyi hesaplamak için bu izne ihtiyacımız var.',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 12)),
                        child: const Text(
                          'İzin ver',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      //Icon(Icons.navigate_next),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Diğer'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text('Uygulama dili'),
                      trailing: Icon(Icons.navigate_next),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: ListTile(
                      leading: Icon(Icons.rocket_launch_sharp),
                      title: Text('Uygulama versiyonu'),
                      trailing: Text('1.0.0'),
                    ),
                  ),
                ),
              ),
            ],
          )
          // ListView.builder(
          //     itemCount: 10,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Card(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         child: Padding(
          //           padding: const EdgeInsets.all(12.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 "Ayar $index",
          //                 style: const TextStyle(fontSize: 36),
          //               ),
          //               Switch(
          //                 value: isSwitched[index],
          //                 onChanged: (value) {
          //                   setState(() {
          //                     isSwitched[index] = value;
          //                   });
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }),
          );
    });
  }
}
