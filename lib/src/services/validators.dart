import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite um email';
  }
  if (!GetUtils.isEmail(email)) {
    return 'Digite um email válido';
  } else {
    return null;
  }
}

String? passwValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite uma senha';
  }
  if (password.length < 6) {
    return 'Senha deve ter minimo de 6 caracteres';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }

  final nomes = name.split(' ');
  if (nomes.length == 1) {
    return 'Digite um nome composto';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite o Telefone';
  }

  if (phone.length < 18 || GetUtils.isPhoneNumber(phone)) {
    return 'Digite um Telefone válido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite o CPF';
  }
  if (!GetUtils.isCpf(cpf)) {
    return 'Digite um CPF válido';
  }
  return null;
}
