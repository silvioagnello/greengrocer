import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/auth/repositories/auth_repository.dart';
import 'package:greengrocer/src/auth/results/auth_result.dart';
import 'package:greengrocer/src/profile/models/user_model.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../common/constants/endpoints.dart';
import '../../pages_routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilsService = UtilsService();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    if (!kIsWeb) {
      validateToken();
    }
  }

  Future<void> validateToken() async {
    String? token = await utilsService.getLocalData(key: Endpoints.token);

    if (token == null) {
      Get.offAllNamed(PagesRoute.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(sucess: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (msg) {
      signOut();
    });
  }

  Future<void> signOut() async {
    user = UserModel();
    await utilsService.removeLocalData(key: Endpoints.token);
    Get.offAllNamed(PagesRoute.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    if (!kIsWeb) {
      utilsService.saveLocalData(key: Endpoints.token, data: user.token!);
    }
    Get.offAllNamed(PagesRoute.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    result.when(sucess: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (msg) {
      utilsService.myToast(msg: msg, isError: true);
    });
    isLoading.value = false;
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;
    //
    result.when(sucess: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (messa) {
      utilsService.myToast(msg: messa, isError: true);
    });
  }
}
