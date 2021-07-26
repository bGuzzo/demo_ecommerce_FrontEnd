class Acquisto {
  int id;
  String data;

  Acquisto({this.id, this.data});

  factory Acquisto.fromJson(Map<String, dynamic> json) {
    return Acquisto(id: json['id'], data: json['data']);
  }

  @override
  String toString() {
    return id.toString() + " " + data;
  }
}
