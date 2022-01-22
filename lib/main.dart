import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wowtalentcalculator/HomeScreen/load_home_screen.dart';
import 'package:wowtalentcalculator/ad_state.dart';
import 'package:wowtalentcalculator/api/purchase_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PurchaseApi.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final initFuture = MobileAds.instance.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AdState>(create: (_) => AdState(initFuture)),
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
        title: 'WoW Talent Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoadHomeScreen());
  }
}
