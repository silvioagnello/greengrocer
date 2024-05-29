import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:greengrocer/src/common/widgets/app_name_widget.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/validators.dart';

import '../../common/widgets/custom_formfield.dart';
import '../controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignInScreen({super.key});
  final emailController =
      TextEditingController(text: 'greengrocerteste@gmail.com');
  final passwController = TextEditingController(text: 'senha123');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: kIsWeb ? size.height - 56 : size.height - 118,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Titulo
                  children: [
                    const AppName(textSize: 40),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 25, color: Colors.white60),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Laticíneos'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Formulário
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45)),
                    color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Campo EMAIL
                      CustomTextFormField(
                          icon: Icons.email,
                          label: 'Email',
                          controller: emailController,
                          validator: emailValidator),
                      // Campo SENHA
                      CustomTextFormField(
                          icon: Icons.lock,
                          label: 'Password',
                          isSecret: true,
                          controller: passwController,
                          validator: passwValidator),
                      // Botão ENTRAR
                      SizedBox(
                        height: 45,
                        child: GetX<AuthController>(builder: (authController) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      String email = emailController.text;
                                      String passw = passwController.text;

                                      authController.signIn(
                                          email: email, password: passw);

                                      // if (!authController.isLoading.value) {
                                      //   Get.offNamed(PagesRoute.baseRoute);
                                      // }
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          );
                        }),
                      ),
                      // Botão ESQUECI A SENHA
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Esqueci a senha',
                                style: TextStyle(
                                    color: CustomColors.customContrastColor),
                              ))),
                      // DIVIDER OU
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(child: Divider(thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text('OU'),
                            ),
                            Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                      ),
                      // Botão CRIAR CONTA
                      SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => SignUpScreen(),
                            //   ),
                            // );
                            Get.toNamed(PagesRoute.signUpRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 2)),
                          child: const Text('CRIAR CONTA'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
