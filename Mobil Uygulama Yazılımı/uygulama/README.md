# Raid Eye

Projemiz, dizaynı yapılan PCB kartımız kamikaze drone'ların cihaza yaklaşıp yaklaşmadığını tespit eder ve bu bilgileri, tehdit durumunu Bluetooth ile bağlandığı mobil arayüze gönderir. Mobil arayüzde ikaz durumu ve diğer çeşitli bilgiler yer alarak görselleştirilir. Haritada güvenli bölge çember içine alınarak görselleştirilmiştir.

## Özellikler

- Kamikaze drone tespiti
- Bluetooth ile veri aktarımı
- Mobil arayüzde tehdit durumunun görselleştirilmesi
- Haritada güvenli bölge gösterimi

## Gereksinimler

Bu projeyi çalıştırmak için aşağıdaki araçlara ihtiyacınız olacak:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)

## Kullanılan Paketler

Bu proje aşağıdaki Flutter paketlerini kullanmaktadır:

- `flutter_map`
- `get`
- `latlong`
- `ble_controller`
- `flutter_blue`
- `permission_handler`
- `syncfusion_flutter_charts`
- `intl`
- `to_csv`
- `shared_preferences`

## Kurulum ve Çalıştırma

Projeyi bilgisayarınızda çalıştırmak için aşağıdaki adımları izleyin:

1. Flutter SDK'yı kurun: [Flutter Kurulum Kılavuzu](https://flutter.dev/docs/get-started/install)
2. Android Studio'yu kurun: [Android Studio İndirme Sayfası](https://developer.android.com/studio)
3. Bu repository'i klonlayın:
    ```sh
    git clone https://github.com/kullaniciadi/raid-eye.git
    ```
4. Proje dizinine gidin:
    ```sh
    cd raid-eye
    ```
5. Gerekli paketleri yükleyin:
    ```sh
    flutter pub get
    ```
6. Android Emulator'ü başlatın ve projeyi çalıştırın:
    ```sh
    flutter run
    ```

## Kullanım

Proje çalıştırıldıktan sonra, mobil arayüz üzerinden cihazın durumu ve tehdit tespiti hakkında bilgileri görebilirsiniz. Haritada güvenli bölge çember içine alınarak gösterilecektir.

## Katkıda Bulunma

Katkıda bulunmak isterseniz, lütfen önce projenin bir fork'unu oluşturun. Değişikliklerinizi yaptıktan sonra bir pull request gönderin.

1. Fork oluşturun: `git clone https://github.com/kullaniciadi/raid-eye.git`
2. Yeni bir dal (branch) oluşturun: `git checkout -b feature/ozellik-adi`
3. Değişikliklerinizi yapın ve commit edin: `git commit -m 'Özellik ekle'`
4. Dalınıza push yapın: `git push origin feature/ozellik-adi`
5. Bir pull request oluşturun

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır. Daha fazla bilgi için `LICENSE` dosyasına bakın.

## Ekip

Bu proje, aşağıdaki ekip üyeleri tarafından geliştirilmiştir:

- Ahmet Yasir Savcı
- Emircan Danışmaz
- Muhammed Hüseyin İsmail

