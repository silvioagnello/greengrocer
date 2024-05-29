class UserModel {
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.cpf,
      this.password,
      this.id,
      this.token});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['fullname'],
        email: map['email'],
        phone: map['phone'],
        cpf: map['cpf'],
        //password: map['password'],
        id: map['id'],
        token: map['token']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'fullname': name,
      'password': password,
      'phone': phone,
      'token': token,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, '
        'email: $email, '
        'phone: $phone, '
        'cpf: $cpf, '
        'password: $password, '
        'id: $id, token: $token}';
  }
}
