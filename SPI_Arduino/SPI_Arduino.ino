#include <SPI.h>
bool handshakeConfirmation;
bool connection=true;;

void setup() {
    Serial.begin(9600);
    SPI.begin();
    SPI.setClockDivider(SPI_CLOCK_DIV2);
    Serial.println("ENVIANDO HANDSHAKE");
    //digitalWrite(SS, LOW);
    handshake();
    connection=true;
}

void loop() {
    if(handshakeConfirmation){
      int resp=0;
      char inputBuffer[20]; // Buffer para almacenar la entrada del usuario
      // Espera a que se ingrese un número desde la terminal serial
      while (!Serial.available()) {
          delay(100); // Espera a que haya datos disponibles en el puerto serial
      }
      // Lee la entrada del usuario hasta que se presiona Enter
      int index = 0;
      while (Serial.available() > 0) {
        char incomingByte = Serial.read();
        if (incomingByte == '\n') {
          break; // Sale del bucle cuando se presiona Enter
        }
        inputBuffer[index++] = incomingByte;
        delay(10); // Pequeña pausa para dar tiempo a recibir los siguientes caracteres
      }
      inputBuffer[index] = '\0';
      
      // Código para la comunicación SPI
    }   
}


void handshake(){
  digitalWrite(SS, LOW); //envia un 0
  int respHandshake=0;
  SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0));
  
  int i=0;
  while (i<3){
    respHandshake=SPI.transfer(5);
    if(respHandshake==0&& i==2){ //debe recibir 0 3 veces para hacer el handshake
      Serial.println("HANDSHAKE CONFIRMADO");
      handshakeConfirmation=true;
      digitalWrite(SS, HIGH); //al recibir el handshake establece el cs de la fpga en 1
      break;  
    }
    if(respHandshake==0){
      i++;
    }
    if(respHandshake!=0){
      Serial.println("HANDSHAKE FALLIDO");
      handshakeConfirmation=false;
      break;  
    }
    delay(1000);
  }
}
