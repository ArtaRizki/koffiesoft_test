import 'package:flutter/material.dart';
import 'package:koffiesoft_test/libraries/sharedpref.dart';
import 'package:koffiesoft_test/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    email: "",
    hp: "",
    firstname: "",
    lastname: "",
    grup: "",
    role: "",
    tglLahir: DateTime.now(),
    jenisKelamin: Status(kode: 0, keterangan: ""),
    id: 0,
    status: Status(kode: 0, keterangan: ""),
    accountStatus: Status(kode: 0, keterangan: ""),
    photo: Photo(
        id: 0,
        filename: "",
        caption: "",
        width: 0,
        height: 0,
        contentType: "",
        uri: ""),
    toko: Toko(
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
    ),
  );

  // get user
  UserModel get user {
    String? val = Prefs().getString("user");
    if (val != null) {
      _user = userModelFromJson(val);
    }
    return _user;
  }

  // set data user
  set user(UserModel user) {
    _user = user;
    Prefs().setString("user", userModelToJson(user));
    notifyListeners();
  }
}
