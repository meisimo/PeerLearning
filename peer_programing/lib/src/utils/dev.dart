import 'dart:math';

const HEX_LETTERS = "0123456789abcdef";

T cast<T> (x) => x is T ? x : x;

String truncateText(String text, int maxLength)=>
  text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;

double truncateDouble(double x,int showNDecimals){
  int tenPower = pow(10, showNDecimals);
  return ((x*tenPower).truncate())/tenPower;
}

String generateRandHex(int length){
  String randString = "";
  Random rand = new Random();
  while (0<length--){
    randString += HEX_LETTERS[rand.nextInt(HEX_LETTERS.length)];
  }
  return randString;
}