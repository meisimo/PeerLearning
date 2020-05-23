
import 'package:connectivity/connectivity.dart';

Future<bool> checkConnectivity() async {
  ConnectivityResult connectivityResult =  await (Connectivity().checkConnectivity());
  if(connectivityResult == ConnectivityResult.mobile || connectivityResult ==  ConnectivityResult.wifi){
    return true;
  } else {
    return false;
  }
}