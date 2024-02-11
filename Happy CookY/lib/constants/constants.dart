import 'package:flutter/material.dart';

String defaultBaseUrl= 'https://172.31.132.67:7034/';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: 'Main Navigator');

////SharedPref keys
///Start With Key 'shp' because This vlaues is Global Constants and SharedPref keys
String shpthemeMode='ThemeMode';
String shploginInfo='loginInfo';
String shpaccessToken='accessToken';
