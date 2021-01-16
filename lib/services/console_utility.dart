import 'dart:io';

import 'package:device_info/device_info.dart';

class ConsoleUtility {
  static void printToConsole(String string) {
    // print('\n\n');
    print('\n =============================App Log==========================>>>\n ' +
        DateTime.now().toIso8601String() +
        '\n ' +
        string +
        '\n<<<==============================================================');
  }

  static printDeviceInfo() async {
    // if (Platform.is)
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = null;

    IosDeviceInfo iosInfo = null;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      final String _deviceDetailedInfo = 'PRINTING DEVICE DEVICE INFO \n\n' +
          '\nAndroidId= ' +
          androidInfo.androidId +
          '\nBord== ' +
          androidInfo.board +
          '\device= ' +
          androidInfo.device +
          '\ndisplay= ' +
          androidInfo.display +
          '\nfingerPrint= ' +
          androidInfo.fingerprint +
          '\nhardware= ' +
          androidInfo.hardware +
          '\nhost= ' +
          androidInfo.host +
          '\nid= ' +
          androidInfo.id +
          '\nmanufacturer= ' +
          androidInfo.manufacturer +
          '\nmodel= ' +
          androidInfo.model +
          '\nproduct= ' +
          androidInfo.product +
          '\ntags= ' +
          androidInfo.tags +
          '\ntype= ' +
          androidInfo.type +
          '\nisPhysical Device=' +
          androidInfo.isPhysicalDevice.toString() +
          '\nSDK  version= ' +
          androidInfo.version.sdkInt.toString();
        
      printToConsole(_deviceDetailedInfo);
    } else {
      iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
    }
  }
}
