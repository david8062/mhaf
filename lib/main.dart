import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sextionary/styles/colors.dart';
import 'package:sextionary/views/home/home.dart';
import 'package:sextionary/views/login/viewModel/login_vm.dart';
import 'package:sextionary/views/login/viewModel/user_register_vm.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRegisterViewModel()),
        ChangeNotifierProvider(create: (_) => LoginVM()),
      ],
      child: MaterialApp(
        title: 'Sexctionary',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundPrimary,
        ),
        home: const Home(),
      ),
    );
  }
}
