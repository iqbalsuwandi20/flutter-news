import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi HomeController menggunakan Get.put untuk dependency injection
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: Obx(() {
        // Jika data sedang dimuat, tampilkan indikator loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Jika tidak ada data yang tersedia, tampilkan pesan "No data available"
        else if (controller.newsData.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        // Jika data tersedia, tampilkan dalam bentuk CustomScrollView dengan SliverAppBar
        else {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text(
                  'News',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true, // Mengatur judul di tengah
                backgroundColor: Colors.black, // Warna latar belakang AppBar
                floating: true, // AppBar akan muncul saat di-scroll ke bawah
                snap:
                    true, // AppBar akan langsung muncul saat di-scroll ke bawah
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final article = controller.newsData[
                        index]; // Mendapatkan artikel berdasarkan indeks
                    return ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(
                              article['urlToImage'],
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                      title: Text(article['title'] ?? 'No title'),
                      subtitle:
                          Text(article['description'] ?? 'No description'),
                      onTap: () {
                        Get.toNamed(Routes.NEWS_DETAIL, arguments: article);
                      },
                    );
                  },
                  childCount:
                      controller.newsData.length, // Jumlah item dalam daftar
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
