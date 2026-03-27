#include <Wire.h>
#include "MAX30105.h"

MAX30105 sensor;

// Control de muestreo (100 Hz)
unsigned long lastSampleTime = 0;
const int sampleInterval = 10; // ms → 100 Hz

void setup() {
  Serial.begin(115200);
  Wire.begin(21, 22);  // ESP32

  if (!sensor.begin(Wire, I2C_SPEED_FAST)) {
    Serial.println("Sensor no encontrado");
    while (1);
  }

  sensor.setup(
    60,    // brillo LED
    4,     // promedio
    2,     // solo IR
    100,   // sample rate
    411,   // pulse width
    4096   // ADC range
  );

  sensor.setPulseAmplitudeRed(0x1F);
  sensor.setPulseAmplitudeIR(0x2F);

  Serial.println("START");
}

void loop() {
  if (millis() - lastSampleTime >= sampleInterval) {
    lastSampleTime = millis();

    long irValue = sensor.getIR();   // ← solo una vez
    long inverted = 200000 - irValue;

    Serial.println(inverted);
  }
}