import 'dart:math';

T cast<T> (x) => x is T ? x : x;

String truncateText(String text, int maxLength)=>
  text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;

double truncateDouble(double x,int showNDecimals){
  int tenPower = pow(10, showNDecimals);
  return ((x*tenPower).truncate())/tenPower;
}