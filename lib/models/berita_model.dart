class BeritaModel {
  final int id;
  final String judul;
  final String isi;
  final String gambar;
  final String nama;
  final String slug;
  final String created_at;

  BeritaModel(
      {required this.id,
      required this.judul,
      required this.isi,
      required this.gambar,
      required this.nama,
      required this.slug,
      required this.created_at});

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
        id: json['id'],
        judul: json['judul'] ?? 'Judul',
        isi: json['isi'] ?? 'Isi',
        gambar: json['gambar'] ??
            'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740',
        slug: json['slug'] ?? 'Slug',
        nama: json['nama'] ?? 'Nama',
        created_at: json['created_at'] ?? 'Tgl Publikasi');
  }
}
