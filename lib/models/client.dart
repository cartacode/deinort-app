import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  final String pid;
  final String name;
  final String city;

  Client({this.pid, this.name, this.city});

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    pid: json["pid"],
    name: json["name"],
    city: json["city"],
  );

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'age': city,
    };
  }
}