import 'package:flutter/material.dart';
import 'package:greengrocer/src/auth/sign_in_screen.dart';
import 'package:greengrocer/src/common/custom_formfield.dart';
import 'package:greengrocer/src/config/app_data.dart' as data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          // BOTÃO SAIR
          IconButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ));
              // SystemNavigator.pop();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextFormField(
            icon: Icons.email,
            label: 'Email',
            readOnly: true,
            initialValue: data.user.email,
          ),
          CustomTextFormField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: data.user.name,
            readOnly: true,
          ),
          CustomTextFormField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: data.user.phone,
            readOnly: true,
          ),
          CustomTextFormField(
            icon: Icons.file_copy,
            label: 'CPF',
            initialValue: data.user.cpf,
            isSecret: true,
            readOnly: true,
          ),
          SizedBox(
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          )
        ],
      ),
    );
  }

  updatePassword() {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Atualização de senha',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const CustomTextFormField(
                    icon: Icons.lock,
                    label: 'Senha atual',
                    isSecret: true,
                  ),
                  const CustomTextFormField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: 'Nova senha'),
                  const CustomTextFormField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: 'Corfirme nova senha'),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Atualizar'))
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}