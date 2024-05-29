import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../common/widgets/custom_formfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final cpfFormatter = MaskTextInputFormatter(
      mask: '### ### ### ##', filter: {'#': RegExp(r'[0-9]')});
  final phoneFormatter = MaskTextInputFormatter(
      mask: '55+ ## # #### ####', filter: {'#': RegExp(r'[0-9]')});
  final emailController = TextEditingController();
  final passwController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              // Botão VOLTAR
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ),
              ),
              Column(
                children: [
                  // Titulo
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                              icon: Icons.email,
                              label: 'Email',
                              textInputType: TextInputType.emailAddress,
                              validator: emailValidator,
                              onSaved: (value) {
                                authController.user.email = value;
                              },
                              controller: emailController),
                          CustomTextFormField(
                              icon: Icons.lock,
                              label: 'Senha',
                              isSecret: true,
                              validator: passwValidator,
                              onSaved: (value) {
                                authController.user.password = value;
                              },
                              controller: passwController),
                          CustomTextFormField(
                            icon: Icons.person,
                            label: 'Nome',
                            controller: nameController,
                            validator: nameValidator,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                          ),
                          CustomTextFormField(
                            icon: Icons.phone,
                            label: 'Celular',
                            inputFormatters: [phoneFormatter],
                            textInputType: TextInputType.phone,
                            controller: phoneController,
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                          ),
                          CustomTextFormField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatters: [cpfFormatter],
                            textInputType: TextInputType.number,
                            controller: cpfController,
                            validator: cpfValidator,
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                          ),
                          SizedBox(
                            height: 45,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Cadastrar usuário',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
