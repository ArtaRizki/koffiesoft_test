// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String hp;
  String firstname;
  String lastname;
  String grup;
  String role;
  DateTime tglLahir;
  Status jenisKelamin;
  int id;
  Status status;
  Status accountStatus;
  Photo photo;
  Toko toko;

  UserModel({
    required this.email,
    required this.hp,
    required this.firstname,
    required this.lastname,
    required this.grup,
    required this.role,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.id,
    required this.status,
    required this.accountStatus,
    required this.photo,
    required this.toko,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] ?? "",
        hp: json["hp"] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        grup: json["grup"] ?? "",
        role: json["role"] ?? "",
        tglLahir: json["tgl_lahir"] == null
            ? DateTime.now()
            : DateTime.parse(json["tgl_lahir"]),
        jenisKelamin: json["jenis_kelamin"] == null
            ? Status(kode: 0, keterangan: "")
            : Status.fromJson(json["jenis_kelamin"]),
        id: json["id"] ?? 0,
        status: json["status"] == null
            ? Status(kode: 0, keterangan: "")
            : Status.fromJson(json["status"]),
        accountStatus: json["account_status"] == null
            ? Status(kode: 0, keterangan: "")
            : Status.fromJson(json["account_status"]),
        photo: json["photo"] == null
            ? Photo(
                id: 0,
                filename: "",
                caption: "",
                width: 0,
                height: 0,
                contentType: "",
                uri: "")
            : Photo.fromJson(json["photo"]),
        toko: json["toko"] == null
            ? Toko(
                nama: "",
                jalan: "",
                kelurahan: "",
                kecamatan: "",
                kota: "",
                provinsi: "",
                kodepos: "",
                detailAlamat: "",
                longitude: 0,
                latitude: 0,
                telp: "",
                email: "",
                slogan: "",
                deskripsi: "",
                aturanBelanja: "",
                aturanRetur: "",
                id: 0,
                status: Status(kode: 0, keterangan: ""),
                logo: [],
              )
            : Toko.fromJson(json["toko"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "hp": hp,
        "firstname": firstname,
        "lastname": lastname,
        "grup": grup,
        "role": role,
        "tgl_lahir":
            "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "id": id,
        "status": status.toJson(),
        "account_status": accountStatus.toJson(),
        "photo": photo.toJson(),
        "toko": toko.toJson(),
      };
}

class Status {
  int kode;
  String keterangan;

  Status({
    required this.kode,
    required this.keterangan,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        kode: json["kode"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "kode": kode,
        "keterangan": keterangan,
      };
}

class Photo {
  int id;
  String filename;
  String caption;
  int width;
  int height;
  String contentType;
  String uri;

  Photo({
    required this.id,
    required this.filename,
    required this.caption,
    required this.width,
    required this.height,
    required this.contentType,
    required this.uri,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        filename: json["filename"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        contentType: json["content_type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "caption": caption,
        "width": width,
        "height": height,
        "content_type": contentType,
        "uri": uri,
      };
}

class Toko {
  String nama;
  String jalan;
  String kelurahan;
  String kecamatan;
  String kota;
  String provinsi;
  String kodepos;
  String detailAlamat;
  int longitude;
  int latitude;
  String telp;
  String email;
  String slogan;
  String deskripsi;
  String aturanBelanja;
  String aturanRetur;
  int id;
  Status status;
  List<Photo> logo;

  Toko({
    required this.nama,
    required this.jalan,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kodepos,
    required this.detailAlamat,
    required this.longitude,
    required this.latitude,
    required this.telp,
    required this.email,
    required this.slogan,
    required this.deskripsi,
    required this.aturanBelanja,
    required this.aturanRetur,
    required this.id,
    required this.status,
    required this.logo,
  });

  factory Toko.fromJson(Map<String, dynamic> json) => Toko(
        nama: json["nama"],
        jalan: json["jalan"],
        kelurahan: json["kelurahan"],
        kecamatan: json["kecamatan"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        kodepos: json["kodepos"],
        detailAlamat: json["detail_alamat"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        telp: json["telp"],
        email: json["email"],
        slogan: json["slogan"],
        deskripsi: json["deskripsi"],
        aturanBelanja: json["aturan_belanja"],
        aturanRetur: json["aturan_retur"],
        id: json["id"],
        status: Status.fromJson(json["status"]),
        logo: List<Photo>.from(json["logo"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "jalan": jalan,
        "kelurahan": kelurahan,
        "kecamatan": kecamatan,
        "kota": kota,
        "provinsi": provinsi,
        "kodepos": kodepos,
        "detail_alamat": detailAlamat,
        "longitude": longitude,
        "latitude": latitude,
        "telp": telp,
        "email": email,
        "slogan": slogan,
        "deskripsi": deskripsi,
        "aturan_belanja": aturanBelanja,
        "aturan_retur": aturanRetur,
        "id": id,
        "status": status.toJson(),
        "logo": List<dynamic>.from(logo.map((x) => x.toJson())),
      };
}
