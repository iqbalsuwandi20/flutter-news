import 'package:get/get.dart';

class NewsDetailController extends GetxController {
  // Menyimpan data artikel yang diterima sebagai argumen dari halaman sebelumnya
  Map<String, dynamic>? article;

  @override
  void onInit() {
    super.onInit();
    // Mendapatkan argumen yang dikirim saat navigasi dan mengonversinya menjadi Map
    article = Get.arguments as Map<String, dynamic>;
  }
}
