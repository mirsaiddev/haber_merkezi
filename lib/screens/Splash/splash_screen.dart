import 'package:flutter/material.dart';
import 'package:news_app_v1/providers/data_provider.dart';
import 'package:news_app_v1/screens/Home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    DataProvider categoriesProvider = Provider.of<DataProvider>(context, listen: false);
    categoriesProvider.getData();
    await Future.delayed(Duration(seconds: 1));
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/assets/icons/logo.png', width: 200, height: 200)),
    );
  }
}
