import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sextionary/views/login/view/register_view.dart';
import '../../../styles/colors.dart';
import '../viewModel/login_vm.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "My hot App",
            style: TextStyle(
              color: AppColors.textColors,
              fontSize: 45.0,
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Consumer<LoginVM>(
            builder: (context, viewModel, child) {
              return _buildForm(context, viewModel);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿No tienes una cuenta?",
                style: TextStyle(color: AppColors.textColors),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const RegisterView()));
                },
                child: const Text(
                  "Regístrate",
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, LoginVM viewModel) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                fillColor: Colors.black,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.setEmail(value),
            ),
            const SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.setPassword(value),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
              ),
              onPressed: () => viewModel.loginUser(context),
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
