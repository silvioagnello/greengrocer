import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/services/validators.dart';

import '../common/widgets/custom_formfield.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          // BOTÃO SAIR
          IconButton(
            onPressed: () {
              authController.signOut();
              //Navigator.of(context).pop();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SignInScreen(),
              //   ),
              // );
              // // SystemNavigator.pop();
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
            //controller: emailController,
            initialValue: authController.user.email,
          ),
          CustomTextFormField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: authController.user.name,
            readOnly: true,
            //controller: nameController,
          ),
          CustomTextFormField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: authController.user.phone,
            readOnly: true,
            //controller: phoneController,
          ),
          CustomTextFormField(
            icon: Icons.file_copy,
            label: 'CPF',
            initialValue: authController.user.cpf,
            isSecret: true,
            readOnly: true,
            //controller: cpfController,
          ),
          // BOTÃO ATUALIZAR SENHA
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
    final currentPasswordController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    final newPassWord = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
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
                    CustomTextFormField(
                      controller: currentPasswordController,
                      icon: Icons.lock,
                      label: 'Senha atual',
                      validator: passwValidator,
                      isSecret: true,
                    ),
                    CustomTextFormField(
                        isSecret: true,
                        controller: newPassWord,
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        validator: passwValidator
                        //controller: newpassController,
                        ),
                    CustomTextFormField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: 'Corfirme nova senha',
                      //controller: checkController,
                      validator: (pass) {
                        final result = passwValidator(pass);
                        if (result != null) {
                          return result;
                        }
                        if (pass != newPassWord.text) {
                          return 'Nova Senha não confere';
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: authController.isLoading.value
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  authController.changePassword(
                                      currentPassword:
                                          currentPasswordController.text,
                                      newPassword: newPassWord.text);
                                }
                              },
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Atualizar'),
                      ),
                    )
                  ],
                ),
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
