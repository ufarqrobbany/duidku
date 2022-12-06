library duidku.globals;

import 'package:flutter/material.dart';

// Jenis Akun
var jenisAkun = [
  {
    'id_jenis_akun': 1,
    'nama_jenis_akun': 'Cash',
    'icon_jenis_akun': Icons.payments
  },
  {
    'id_jenis_akun': 2,
    'nama_jenis_akun': 'E-wallet',
    'icon_jenis_akun': Icons.account_balance_wallet
  },
  {
    'id_jenis_akun': 3,
    'nama_jenis_akun': 'Akun Bank',
    'icon_jenis_akun': Icons.account_balance
  },
];

int jenisakunSelected = 1;

// Akun
class DataAkunObject {
  DataAkunObject(
      {required this.idAkun,
      required this.namaAkun,
      required this.iconAkun,
      required this.saldoAkun,
      required this.idJenisAkun});
  int idAkun;
  String namaAkun;
  IconData iconAkun;
  int saldoAkun;
  int idJenisAkun;
}

List<DataAkunObject> akun = [];

// Saldo
int jumlahSaldo = 0;
int pemasukan = 0;
int pengeluaran = 0;

// Kategori Pemasukan
class DataKategoriPemasukanObject {
  DataKategoriPemasukanObject({
    required this.idKategoriPemasukan,
    required this.namaKategoriPemasukan,
    required this.iconKategoriPemasukan,
  });
  int idKategoriPemasukan;
  String namaKategoriPemasukan;
  IconData iconKategoriPemasukan;
}

List<DataKategoriPemasukanObject> kategoriPemasukan = [
  DataKategoriPemasukanObject(
    idKategoriPemasukan: 1,
    namaKategoriPemasukan: 'Gaji',
    iconKategoriPemasukan: Icons.paid,
  ),
  DataKategoriPemasukanObject(
    idKategoriPemasukan: 2,
    namaKategoriPemasukan: 'Bonus dan Tunjangan',
    iconKategoriPemasukan: Icons.payments,
  ),
  DataKategoriPemasukanObject(
    idKategoriPemasukan: 3,
    namaKategoriPemasukan: 'Pendapatan Pasif atau Bisnis',
    iconKategoriPemasukan: Icons.business,
  ),
  DataKategoriPemasukanObject(
    idKategoriPemasukan: 4,
    namaKategoriPemasukan: 'Pendapatan Lainnya',
    iconKategoriPemasukan: Icons.redeem,
  ),
];

int kategoriPemasukanSelected = 1;

// Kategori Pengeluaran
class DataKategoriPengeluaranObject {
  DataKategoriPengeluaranObject({
    required this.idKategoriPengeluaran,
    required this.namaKategoriPengeluaran,
    required this.iconKategoriPengeluaran,
  });
  int idKategoriPengeluaran;
  String namaKategoriPengeluaran;
  IconData iconKategoriPengeluaran;
}

List<DataKategoriPengeluaranObject> kategoriPengeluaran = [
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 1,
    namaKategoriPengeluaran: 'Pajak',
    iconKategoriPengeluaran: Icons.receipt_long,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 2,
    namaKategoriPengeluaran: 'Sedekah atau Donasi',
    iconKategoriPengeluaran: Icons.volunteer_activism,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 3,
    namaKategoriPengeluaran: 'Cicilan atau Hutang',
    iconKategoriPengeluaran: Icons.credit_card,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 4,
    namaKategoriPengeluaran: 'Pendidikan',
    iconKategoriPengeluaran: Icons.school,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 5,
    namaKategoriPengeluaran: 'Tagihan Bulanan',
    iconKategoriPengeluaran: Icons.receipt_long,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 6,
    namaKategoriPengeluaran: 'Belanja Bulanan Rumah Tangga',
    iconKategoriPengeluaran: Icons.shopping_cart,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 7,
    namaKategoriPengeluaran: 'Makanan',
    iconKategoriPengeluaran: Icons.local_dining,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 8,
    namaKategoriPengeluaran: 'Pengeluaran Pribadi',
    iconKategoriPengeluaran: Icons.payments,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 9,
    namaKategoriPengeluaran: 'Kendaraan',
    iconKategoriPengeluaran: Icons.directions_car,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 10,
    namaKategoriPengeluaran: 'Kesehatan',
    iconKategoriPengeluaran: Icons.local_hospital,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 11,
    namaKategoriPengeluaran: 'Liburan',
    iconKategoriPengeluaran: Icons.villa,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 12,
    namaKategoriPengeluaran: 'Hobi',
    iconKategoriPengeluaran: Icons.sports_esports,
  ),
  DataKategoriPengeluaranObject(
    idKategoriPengeluaran: 13,
    namaKategoriPengeluaran: 'Biaya Lainnya',
    iconKategoriPengeluaran: Icons.local_atm,
  ),
];

int kategoriPengeluaranSelected = 1;
int dariAkunSelected = 1;
int dariAkunSelectedTF = 1;
int AkunTujuanSelected = 1;
int AkunTujuanSelectedTF = 1;

// Transaksi
class DataTransaksiObject {
  DataTransaksiObject({
    required this.idTransaksi,
    required this.jenisTransaksi,
    required this.jumlahTransaksi,
    required this.idKategori,
    required this.idDariAkun,
    required this.idAkunTujuan,
    required this.tanggal,
    required this.waktu,
    required this.keterangan,
  });
  int idTransaksi;
  String jenisTransaksi;
  int jumlahTransaksi;
  int idKategori;
  int idDariAkun;
  int idAkunTujuan;
  String tanggal;
  String waktu;
  String keterangan;
}

List<DataTransaksiObject> transaksi = [];
