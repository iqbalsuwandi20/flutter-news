import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_detail_controller.dart';

class NewsDetailView extends StatelessWidget {
  // Inisialisasi NewsDetailController menggunakan Get.put untuk dependency injection
  final NewsDetailController controller = Get.put(NewsDetailController());

  NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar untuk menampilkan judul halaman detail berita
      appBar: AppBar(
        title: const Text(
          'News Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Mengatur judul di tengah
        backgroundColor: Colors.black, // Warna latar belakang AppBar
        leading: const SizedBox(), // Menghilangkan tombol kembali
      ),
      // Body menggunakan SingleChildScrollView agar bisa di-scroll jika kontennya panjang
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar konten
        // Menggunakan GetBuilder untuk menghubungkan view dengan controller
        child: GetBuilder<NewsDetailController>(
          builder: (controller) {
            // Mendapatkan data artikel dari controller
            final article = controller.article;
            // Jika tidak ada data, tampilkan pesan "No data available"
            if (article == null) {
              return const Center(child: Text('No data available'));
            }
            // Jika data tersedia, tampilkan detail artikel
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan gambar artikel jika tersedia
                if (article['urlToImage'] != null)
                  Image.network(
                    article['urlToImage'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16.0), // Spasi antar elemen
                // Menampilkan judul artikel
                Text(
                  article['title'] ?? 'No title',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0), // Spasi antar elemen
                // Menampilkan deskripsi artikel
                Text(
                  article['description'] ?? 'No description',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16.0), // Spasi antar elemen
                // Menampilkan konten artikel
                Text(
                  article['content'] ?? 'No content',
                  style: const TextStyle(fontSize: 16),
                  softWrap: true, // Membungkus teks jika terlalu panjang
                  overflow:
                      TextOverflow.visible, // Teks dapat meluap secara vertikal
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
