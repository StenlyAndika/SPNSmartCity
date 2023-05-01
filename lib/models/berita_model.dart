class BeritaModel {
  int? code;
  String? message;
  List<Payload>? payload;

  BeritaModel({this.code, this.message, this.payload});

  BeritaModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  int? id;
  String? judul;
  String? isi;
  String? gambar;
  String? nama;
  String? slug;
  String? createdAt;
  String? updatedAt;

  Payload(
      {this.id,
      this.judul,
      this.isi,
      this.gambar,
      this.nama,
      this.slug,
      this.createdAt,
      this.updatedAt});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    isi = json['isi'];
    gambar = json['gambar'];
    nama = json['nama'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['isi'] = isi;
    data['gambar'] = gambar;
    data['nama'] = nama;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
