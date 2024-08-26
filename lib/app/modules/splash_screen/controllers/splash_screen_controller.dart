import 'package:get/get.dart';

import '../../home/views/home_view.dart';

class SplashScreenController extends GetxController {
  // Durasi splash screen dalam hitungan detik
  final int splashDuration = 5;

  @override
  void onInit() {
    super.onInit();
    // Menunggu selama `splashDuration` detik sebelum pindah ke HomeView
    Future.delayed(Duration(seconds: splashDuration), () {
      // Mengarahkan pengguna ke halaman HomeView setelah SplashScreen
      Get.offAll(() => const HomeView());
    });
  }
}
