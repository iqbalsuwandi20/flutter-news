import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController extends GetxController {
  // Observable list untuk menyimpan data berita yang akan ditampilkan
  var newsData = [].obs;

  // Observable boolean untuk menunjukkan apakah data sedang dimuat
  var isLoading = true.obs;

  // Instance dari FlutterSecureStorage untuk menyimpan dan mengambil data secara aman
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    saveApiToken(); // Simpan token API saat controller diinisialisasi
    fetchNews(); // Panggil fungsi untuk mengambil berita saat controller diinisialisasi
  }

  // Method untuk menyimpan token API secara aman menggunakan FlutterSecureStorage
  Future<void> saveApiToken() async {
    await storage.write(
        key: 'api_token',
        value:
            '592e20acadf64e0ab00f999b8a25f92e'); // Simpan token API ke dalam penyimpanan
  }

  // Method untuk mengambil berita dari API
  void fetchNews() async {
    try {
      // Baca token API dari penyimpanan
      String? apiKey = await storage.read(key: 'api_token');

      // Jika token tidak ditemukan, tampilkan pesan error
      if (apiKey == null) {
        Get.snackbar('Error', 'Token API tidak ditemukan');
        return;
      }

      // Kirim permintaan GET ke API berita menggunakan token
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=tesla&apiKey=$apiKey'),
      );

      // Jika respon berhasil, parse data dan simpan ke dalam newsData
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        newsData.value = data['articles'];
      }
      // Jika gagal, tampilkan pesan error
      else {
        Get.snackbar('Error', 'Gagal memuat data');
      }
    }
    // Tangkap dan tangani kesalahan yang terjadi saat mengambil data
    catch (e) {
      Get.snackbar('Error', 'Gagal memuat data');
    }
    // Set isLoading menjadi false setelah proses selesai
    finally {
      isLoading.value = false;
    }
  }
}
