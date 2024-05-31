# Raid Eye - Kamikaze İHA Sinyal Tespit ve İkaz Sistemi

## Proje Tanıtımı
Raid Eye projesi, askerlerimizin güvenliğini tehdit eden kamikaze insansız hava araçlarına (İHA) karşı önlem almak için geliştirilmiştir. Projenin temel amacı şu şekilde özetlenebilir:

Kamikaze İHA'ların 5.8 GHz frekansındaki kontrol ve görüntü aktarım sinyallerini tespit etmek
Bu sinyallerin kuvvetini ölçerek yaklaşan tehlikeyi belirlemek
Tespit edilen tehlikeyi sesli uyarı sistemiyle askerlerimize bildirerek önlem alınmasını sağlamak
Böylece, FPV (First Person View) teknolojisi kullanan kamikaze İHA'ların neden olabileceği kayıpların önüne geçilmesi hedeflenmektedir. Maverick Space ekibi, askeri operasyonlarda
bilinmeyen alanlarda karşılaşılabilecek bu tehdidin önlenmesi için Raid Eye projesini geliştirmiştir.

Kısaca, Raid Eye sistemi, 5.8 GHz frekansındaki sinyalleri algılayarak yaklaşan kamikaze İHA'lara karşı askerlerimizi önceden uyaran bir güvenlik çözümüdür.

Donanım Tasarım Görselleri
![3d_2](https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/49c3576d-6269-490d-9b04-5b45fe780e9d)


https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/f9e3f8c7-b252-42bd-ad0d-98eca6fa7957


![animasyon_gorsel2](https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/de0e37e4-f500-4f13-b7f6-5c95405c00d3)

Sistem blok şeması
![Başlıksız Diyagram drawio](https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/a34f2eb2-b08f-43e4-9bfe-52c5d0b987e8)

Gömülü yazılımın çalıtığını proteus ile simüle edilmiştir.

![simülasyon_jpg](https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/ac5edc8a-0646-4af3-8603-97ec0a494ca9)


## Dosya Yapısı
- **Donanım Tasarım/**: PCB tasarım dosyaları, montaj animasyon videosu ve 3D kutu tasarımı.
- **Gömülü Yazılımı/**: Gömülü yazılım kaynak kodları ve dokümantasyonu.
- **Mobil Uygulama Yazılımı/**: Arayüz yazılımı kaynak kodları ve dokümantasyonu.
- **Rapor ve Sunum/**: Proje raporları ve sunumları.

## Kurulum ve Çalıştırma
### Donanım
- PCB dosyalarını `Donanım Tasarımı\hecatlon_raid_eye\gerber_to_order` klasöründen indirin ve bir PCB üreticisine gönderin.
-Raid Eye kartının dizgisi için gerekli olan dosyaları ‘Donanım Tasarımı\hecatlon_raid_eye\bom’ malzemeler sipariş verilerek dizgi işlemi yapılabilir.
- Montaj talimatlarına `Donanım Tasarımı\hecatlon_raid_eye\bom` dosyasından ulaşabilirsiniz. Dizgi işleminde süreci hızlandırma bir eklenti ile hazırlanmıştır.

![image](https://github.com/MHI-Embedded-Dev/MaverickSpace-RaidEye/assets/132624287/60c851f9-c9f8-4316-abf7-87e501cdb877)

### Gömülü Yazılım
- Gömülü yazılım kaynak kodlarını iki kısıma ayrılmaktadır. ESP32 ve STM32 tarafı olmak üzere STM32 kodları `Gömülü Yazılımı\STM32F446RE\Hecaton_Raid_EYE\Core\Src\main.c` algoritma işleyişi ve sensörleri okuma işlemini yapar. klasöründen bulun.
-ESP32 kodları ‘Gömülü Yazılımı\ESP32-WROOM\Raid_Eye_ESP32’ bluetooth ile mobil uygulamaya bağlantısı gerçekleştirilir. Yapılan sinyal ölçümleri ve ikaz durumu mobil uygulamaya iletilmektedir.
- Yazılımın nasıl yükleneceği ve çalıştırılacağı ile ilgili bilgi için 
ESP32 kodu ve çalıştırma readme dosyası`C:\Github\MaverickSpace-RaidEye\Gömülü Yazılımı\ESP32-WROOM\Raid_Eye_ESP32\readme.txt` dosyasına bakın.
STM32  kodu ve çalıştırma readme dosyası` Gömülü Yazılımı\STM32F446RE\Hecaton_Raid_EYE` dosyasına bakın.

### Arayüz Yazılımı
- Arayüz yazılımı kaynak kodlarını ` Mobil Uygulama Yazılımı\uygulama\src\main.c` klasöründen bulun.
- Mobil Uygulama kodu ve çalıştırma readme dosyası ‘Mobil Uygulama Yazılımı\uygulama\README.txt’ dosyasına bakın.

## İletişim
Muhammed Hüseyin İSMAİL -> mhi.hsynn@gmail.com

