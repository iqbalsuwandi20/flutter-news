import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import '../../home/views/home_view.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan GetBuilder untuk menghubungkan view dengan controller
      body: GetBuilder<SplashScreenController>(
        // Inisialisasi SplashscreenController
        init: SplashScreenController(),
        // Membangun UI splash screen
        builder: (controller) => FlutterSplashScreen.scale(
          // Gradien warna untuk latar belakang splash screen
          gradient: const LinearGradient(
            colors: [
              Colors.black,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          // Widget anak berupa gambar logo yang ditampilkan di splash screen
          childWidget: SizedBox(
            height: 200,
            child: Image.asset("assets/iconsplash.png"),
          ),
          // Durasi splash screen, mengambil dari controller
          duration: Duration(seconds: controller.splashDuration),
          // Durasi animasi splash screen
          animationDuration: const Duration(seconds: 4),
          // Callback ketika animasi berakhir
          onAnimationEnd: () => debugPrint("On Scale End"),
          // Layar berikutnya setelah splash screen selesai, akan diatur oleh controller
          nextScreen: const HomeView(),
        ),
      ),
    );
  }
}
