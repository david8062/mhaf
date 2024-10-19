import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../../../styles/colors.dart';
import '../../home/home.dart';
import '../viewModel/user_register_vm.dart';


class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
          Consumer<UserRegisterViewModel>(
            builder: (context, viewModel, child) {
              return _buildForm(context, viewModel);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿Ya estás registrado?",
                style: TextStyle(color: AppColors.textColors),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text(
                  "Inicia Sesión",
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, UserRegisterViewModel viewModel) {
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
                "Registro",
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
                labelText: 'Nickname',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.setName(value),
            ),
            const SizedBox(height: 15),
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
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => viewModel.setConfirmPassword(value),
            ),
            const SizedBox(height: 15),
            DateTimePicker(
              decoration: const InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(),
              ),
              dateMask: 'yyyy-MM-dd',
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              onChanged: (value) => viewModel.setBirthdate(value),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
              ),
              onPressed: () => viewModel.registerUser(context),
              child: const Text(
                'Registrarse',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
