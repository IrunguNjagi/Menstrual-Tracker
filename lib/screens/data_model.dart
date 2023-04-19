//this model defines the fields that can be extracted from the table in the database.

class DataModel {
  int id;
  String data;

  DataModel({this.id, this.data});

  Map<String, dynamic> toMap() {
    return {'id': id, 'data': data};
  }
}
