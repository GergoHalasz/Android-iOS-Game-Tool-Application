import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wowtalentcalculator/HomeScreen/load_home_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';
import 'package:applovin_max/applovin_max.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MaxConfiguration? sdkConfiguration = await AppLovinMAX.initialize(
      "kaiKyd46T_t3T_b0bZOGmiKUugqBnAd6wtKOKurlbl59gHTsBZeP62kg58gabcloF0n2rXuoFypnDZd9zk6Mlf");
  await PurchaseApi.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AdState>(create: (_) => AdState()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Classic Talent Calculator',
        debugShowCheckedModeBanner: false,
        home: LoadHomeScreen());
  }
}
