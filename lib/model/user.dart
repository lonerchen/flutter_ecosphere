
class User{

  late int id;

  late String name;

  late String phone;

  late String password;

  late int created_at;

  User(this.id, this.name, this.phone, this.password, this.created_at);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['created_at'] = this.created_at;
    return data;
  }

}