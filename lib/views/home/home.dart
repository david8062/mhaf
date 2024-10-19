import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../login/view/login_view.dart';
import '../login/view/register_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logos/logo_main.png"),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all(const Size(200.0, 40.0)),
                  maximumSize:
                      MaterialStateProperty.all(const Size(200.0, 40.0)),
                  backgroundColor:
                      const MaterialStatePropertyAll(AppColors.secondaryColor),
                ),
                child: const Text(
                  "login",
                  style: TextStyle(fontSize: 20, color: AppColors.textColors),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                 onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                  },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all(const Size(200.0, 40.0)),
                  maximumSize:
                      MaterialStateProperty.all(const Size(200.0, 40.0)),
                  backgroundColor:
                      const MaterialStatePropertyAll(AppColors.secondaryColor),
                ),
                child: const Text(
                  "Registrarse",
                  style: TextStyle(fontSize: 20, color: AppColors.textColors),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "¿No tienes una cuenta? ",
                  style: TextStyle(color: AppColors.textColors),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                  },
                  child: const Text(
                    "Registrate",
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
