#include <SPI.h>
#include <SD.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <Wire.h>

#define I2C_SLAVE_ADDRESS 0x30
#define BUFFER_SIZE 10

// Veri alındı bayrağı
volatile bool dataReceived = false;

// I2C veri tamponu
volatile uint8_t buffer[BUFFER_SIZE];
volatile int bufferLength = 0;

// Batarya seviyesi pin tanımı
const int Battery_Level_Pin = 12;

// Doppler sabitleri
const float soundSpeed = 343.0; 
const float sourceFrequency = 2400000.0;

// LED pinleri
const int LED1 = 33; // Batarya Seviyesi
const int LED3 = 32; // BLE
uint8_t ikaz_sayac = 0;

// SD kart pin tanımları
const int chipSelect = 5;
const int writeInterval = 1000; 
unsigned long lastWriteTime = 0;

// Frekans ve diğer değişkenler
long frequency;
float freq_ghz;
float dopplerShift;
float speed;

// BLE bağlantı durumu
bool ble_connected = false;
uint8_t ble_sayac = 0;

// BLE servis ve karakteristik tanımlamaları
BLECharacteristic *pCharacteristic;

// Son BLE gönderim zamanı ve gönderim aralığı
unsigned long lastSendTime = 0;
const unsigned long sendInterval = 200; 

// BLE bağlantı durumu için geri arama sınıfı
class MyServerCallbacks : public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      ble_connected = true;
    };
    void onDisconnect(BLEServer* pServer) {
      ble_connected = false;
    };
};

void setup() {
  Serial.begin(115200);

  pinMode(LED1, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(Battery_Level_Pin, INPUT);

  Wire.begin(I2C_SLAVE_ADDRESS);
  Wire.onReceive(receiveEvent);

  if (!SD.begin(chipSelect)) {
    Serial.println("Kart başlatılamadı. Karta erişilemiyor!");
    return;
  }

  BLEDevice::init("Raid Eye");
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  BLEService *pService = pServer->createService(BLEUUID("4fafc201-1fb5-459e-8fcc-c5c9c331914b"));
  pCharacteristic = pService->createCharacteristic(
                      BLEUUID("beb5483e-36e1-4688-b7f5-ea07361b26a8"),
                      BLECharacteristic::PROPERTY_READ |
                      BLECharacteristic::PROPERTY_WRITE |
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_INDICATE
                    );
  pCharacteristic->setValue("RaidEye_BLE");
  pCharacteristic->addDescriptor(new BLE2902());
  pService->start();
  pServer->getAdvertising()->start();
}

void loop() {
  if (dataReceived) {
    processI2CData();
    dataReceived = false; 
  }

  sdCardWriteData();
  checkBLEConnection();
  sendBLEData();
}

void processI2CData() {
  frequency = ((long)buffer[3] << 40) | ((long)buffer[4] << 32) |
              ((long)buffer[5] << 24) | ((long)buffer[6] << 16) |
              ((long)buffer[7] << 8) | buffer[8];

  Serial.printf("Frekans ayarı komutu alındı: %ld Hz\n", frequency);

  freq_ghz = frequency / 1000000.0;

  if (buffer[10] == 1) {
    audibleAlertSystem();
  }

  dopplerShift = frequency - sourceFrequency; 
  speed = calculateSpeed(dopplerShift, sourceFrequency, soundSpeed);
}

void sdCardWriteData() {
  unsigned long currentTime = millis(); 
  if (currentTime - lastWriteTime >= writeInterval) {
    lastWriteTime = currentTime;
    File dataFile = SD.open("raid_eye_data.txt", FILE_WRITE);
    if (dataFile) {
      for (int i = 0; i < BUFFER_SIZE; i++) {
        dataFile.print(buffer[i]);
        dataFile.print('\t');
      }
      dataFile.println();
      dataFile.close();
      Serial.println("Veri yazma işlemi tamamlandı.");
    } else {
      Serial.println("Veri dosyası açılamadı.");
    }
  }
}

void sendBLEData() {
  unsigned long currentTime = millis();
  if (currentTime - lastSendTime >= sendInterval) {
    pCharacteristic->setValue(convertArrayToString(buffer, BUFFER_SIZE));
    pCharacteristic->notify(); 
    lastSendTime = currentTime;
  }
}

String convertArrayToString(const uint8_t *array, size_t length) {
  String str = "";
  for (size_t i = 0; i < length; i++) {
    str += String(array[i]);
    if (i < length - 1) {
      str += ", "; 
    }
  }
  return str;
}

void audibleAlertSystem() {
  digitalWrite(LED1, !digitalRead(LED1));
  delay(50);
  if (ikaz_sayac > 20) {
    ikaz_sayac = 0;
    digitalWrite(LED1, LOW); 
  }
}

void checkBLEConnection() {
  if(ble_connected == true){
    ble_sayac++;
    if(ble_sayac<10){
      digitalWrite(LED3, !digitalRead(LED3));
      delay(5);
    }
    else{
      ble_sayac=0;
      digitalWrite(LED3, HIGH);
    }
  }
}

void receiveEvent(int howMany) {
  bufferLength = 0;
  while (Wire.available()) {
    buffer[bufferLength++] = Wire.read();
  }
  dataReceived = true;
}

float calculateSpeed(float dopplerShift, float sourceFrequency, float soundSpeed) {
  return (dopplerShift * soundSpeed) / (2.0 * sourceFrequency);
}