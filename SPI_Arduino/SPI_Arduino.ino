#include <SPI.h>

bool handshakeConfirmation; // Variable para confirmar el handshake
bool connection = true; // Variable para indicar el estado de la conexión

void setup() {
  Serial.begin(9600); // Inicializa la comunicación serial a 9600 baudios
  SPI.begin(); // Inicializa la comunicación SPI
  SPI.setClockDivider(SPI_CLOCK_DIV2); // Configura el divisor de reloj SPI
  Serial.println("ENVIANDO HANDSHAKE"); // Imprime un mensaje de inicio
  
  //digitalWrite(SS, LOW); // (Comentario) Descomentar si se utiliza el pin SS
  handshake(); // Realiza el handshake
  connection = true; // Establece la conexión como verdadera
}

void loop() {
  if (handshakeConfirmation) { // Si se ha confirmado el handshake
    int resp = 0; // Variable para almacenar la respuesta del dispositivo
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
    inputBuffer[index] = '\0'; // Asegura que el buffer termine con un carácter nulo
    
    SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0)); // Inicia la transacción SPI
    
    int toSend;
    // Itera sobre el buffer de entrada
    for (int i = 0; inputBuffer[i] != '\0'; i++) {
      char digit = inputBuffer[i];
      // Verifica si el carácter es un dígito o un carácter hexadecimal
      if (digit >= '0' && digit <= '9') {
        toSend = (digit - '0'); // Convierte el carácter en un número y lo envía
      } else if (digit >= 'A' && digit <= 'F') {
        toSend = (10 + (digit - 'A')); // Convierte el carácter en un número hexadecimal y lo envía
      }
      Serial.println("Enviando uno de los bits de operacion: ");
      Serial.println(toSend);
      resp = SPI.transfer(toSend); // Envía el dato y recibe la respuesta
      Serial.println("La respuesta es:");
      Serial.println(resp); // Imprime la respuesta
      
      // Manejo de la respuesta
      if (resp > 15) {
        Serial.println("SIN MENSAJE");
        for (int i = 0; i < 3; i++) {
          resp = SPI.transfer(toSend); // Intenta enviar nuevamente si no hay respuesta
          if (resp > 15 && i == 2) { // Si la respuesta es mayor que 15 y en más de 2 ciclos llega lo mismo, entonces se hace el reset
            Serial.print(i + 1);
            Serial.println("");
            Serial.println("CONEXION PERDIDA, REINICIE EL SISTEMA");
            connection = false; // Establece la conexión como falsa
            break;
          }
          if (resp > 15) {
            Serial.print(i + 1);
            Serial.print("...");
          } else {
            break;
          }
          delay(1000);
        }
      } else {
        Serial.println(resp); // Imprime la respuesta si es válida
      }

      // Finaliza la transacción SPI si hay conexión, de lo contrario, aborta
      if (connection) {
        SPI.endTransaction();
      } else {
        delay(5000);
        abort();
      }
      
      delay(1000); // Espera 1 segundo antes de la siguiente iteración
    }
  }   
}

void handshake() {
  digitalWrite(SS, LOW); // (Comentario) Establece el pin SS en bajo para iniciar la comunicación con el dispositivo
  int respHandshake = 0; // Variable para almacenar la respuesta del handshake
  
  SPI.beginTransaction(SPISettings(1000000, MSBFIRST, SPI_MODE0)); // Inicia la transacción SPI
  
  int i = 0;
  while (i < 3) { // Realiza el handshake hasta 3 intentos
    respHandshake = SPI.transfer(5); // Envía el dato para el handshake y recibe la respuesta
    if (respHandshake == 0 && i == 2) { // Debe recibir 0 3 veces para hacer el handshake
      Serial.println("HANDSHAKE CONFIRMADO");
      handshakeConfirmation = true; // Establece la confirmación del handshake como verdadera
      digitalWrite(SS, HIGH); // (Comentario) Al recibir el handshake establece el cs de la FPGA en 1
      break;  
    }
    if (respHandshake == 0) {
      i++;
    }
    if (respHandshake != 0) {
      Serial.println("HANDSHAKE FALLIDO");
      handshakeConfirmation = false; // Establece la confirmación del handshake como falsa
      break;  
    }
    delay(1000); // Espera 1 segundo antes de realizar el siguiente intento
  }
}
