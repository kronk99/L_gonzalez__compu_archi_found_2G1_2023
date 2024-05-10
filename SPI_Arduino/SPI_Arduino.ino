#include <SPI.h>

bool handshakeConfirmation;
bool connection = true;

void setup() {
    Serial.begin(9600);
    SPI.begin();
    SPI.setClockDivider(SPI_CLOCK_DIV2);
    Serial.println("ENVIANDO HANDSHAKE");
    handshake();
    connection = true;
}

void loop() {
    // Resto del código para el bucle principal...
}

void handshake() {
    digitalWrite(SS, LOW); // Envía un 0
    int respHandshake = 0;
    SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0));
  
    int i = 0;
    while (i < 3) {
        respHandshake = SPI.transfer(5);
        if (respHandshake == 0 && i == 2) {
            Serial.println("HANDSHAKE CONFIRMADO");
            handshakeConfirmation = true;
            digitalWrite(SS, HIGH);
            break;  
        }
        if (respHandshake == 0) {
            i++;
        }
        if (respHandshake != 0) {
            Serial.println("HANDSHAKE FALLIDO");
            handshakeConfirmation = false;
            break;  
        }
        delay(1000);
    }
}
