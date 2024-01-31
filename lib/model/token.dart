
class Token{

  int? id;

  late String token;

  String? creation_time;

  late String expiration_time;

  late String user_id;

  late String device_id;

  Token(this.token, this.expiration_time, this.user_id, this.device_id);

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    creation_time = json['creation_time'];
    expiration_time = json['expiration_time'];
    user_id = json['user_id'];
    device_id = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id != null){
      data['id'] = id;
    }
    data['token'] = token;
    if(creation_time != null) {
      data['creation_time'] = this.creation_time;
    }
    data['expiration_time'] = this.expiration_time;
    data['user_id'] = this.user_id;
    data['device_id'] = this.device_id;
    return data;
  }


}