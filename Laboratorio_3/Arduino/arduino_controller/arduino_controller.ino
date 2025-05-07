int LEFT_BTN = 8;
int RIGHT_BTN = 9;
int ACCEPT_BTN = 10;

int rightState = 0;
int lastRightState = 0;

int leftState = 0;
int lastLeftState = 0;

int acceptState = 0;
int lastAcceptState = 0;

int incomingByte = 0;
int message[8] = {0, 0, 0, 1, 0, 0, 0, 0};
int message2[8] = {0, 0, 0, 0, 1, 0, 0, 0};
int message3[8] = {0, 1, 0, 0, 0, 0, 0, 0};

void setup() {
  pinMode(LEFT_BTN, INPUT_PULLUP);
  pinMode(RIGHT_BTN, INPUT_PULLUP);
  pinMode(ACCEPT_BTN, INPUT_PULLUP);
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  leftState = digitalRead(LEFT_BTN);
  rightState = digitalRead(RIGHT_BTN);
  acceptState = digitalRead(ACCEPT_BTN);

  if (leftState != lastLeftState) {
    if (leftState == LOW) {
      Serial.write(1);
    }                 
  }
  lastLeftState = leftState;

  if (rightState != lastRightState) {
    if (rightState == LOW) {
      Serial.write(2);
    }
  }
  lastRightState = rightState;

  if (acceptState != lastAcceptState) {
    if (acceptState == LOW) {
      Serial.write(3);
    }
  }
  lastAcceptState = acceptState;

   if (Serial.available() > 0) {

        // read the incoming byte:

        incomingByte = Serial.read();


        // say what you got:

        Serial.print("I received: ");

        Serial.println(incomingByte, DEC);
   }
}
