

class DataModel {
  int id;
  String data;

  DataModel({this.id, this.data});

  Map<String, dynamic> toMap() {
    return {'id': id, 'data': data};
  }
}
