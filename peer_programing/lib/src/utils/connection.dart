
import 'package:connectivity/connectivity.dart';

Future<bool> checkConnectivity() async {
  ConnectivityResult connectivityResult =  await (Connectivity().checkConnectivity());
  if(connectivityResult == ConnectivityResult.mobile || connectivityResult ==  ConnectivityResult.wifi){
    return true;
  } else {
    return false;
  }
}

void handleConnectivity({Function onSuccess, Function onError, Function onResponse}) => 
  checkConnectivity().then((bool  connected){
    if (onResponse != null)
      onResponse();
    if(connected && onSuccess != null)
      onSuccess();
    else if (!connected && onError != null)
      onError();
  });