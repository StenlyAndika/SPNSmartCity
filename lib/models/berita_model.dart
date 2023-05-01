class BeritaModel {
  int id;
  String judul;
  String isi;
  String gambar;
  String nama;
  String slug;
  String createdAt;

  BeritaModel(
      {required this.id,
      required this.judul,
      required this.isi,
      required this.gambar,
      required this.nama,
      required this.slug,
      required this.createdAt});

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
        id: json['id'],
        judul: json['judul'] ?? 'Judul',
        isi: json['isi'] ?? 'Isi',
        gambar: json['gambar'] ??
            'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740',
        slug: json['slug'] ?? 'Slug',
        nama: json['nama'] ?? 'Nama',
        createdAt: json['created_at'] ?? 'Tgl Publikasi');
  }
}
