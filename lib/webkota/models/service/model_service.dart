class ServiceModel {
  int? code;
  String? message;
  Payload? payload;

  ServiceModel({this.code, this.message, this.payload});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  List<Data>? data;

  Payload({this.data});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? nama;
  String? ket;
  String? link;
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.nama,
      this.ket,
      this.link,
      this.gambar,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    ket = json['ket'];
    link = json['link'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['ket'] = ket;
    data['link'] = link;
    data['gambar'] = gambar;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
