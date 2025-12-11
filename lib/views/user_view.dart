// ============================================
// KULLANICI LİSTESİ SAYFASI (VIEW)
// ============================================
// Bu dosya kullanıcı arayüzünü (UI) oluşturur.
// Controller'dan gelen verileri ekranda gösterir.
// MVC mimarisindeki "View" katmanıdır.

import 'package:flutter/material.dart';

// Detay sayfasına yönlendirmek için import ediyoruz
import 'package:flutterlearn/views/user_detail_view.dart';

// GetX paketini import ediyoruz
import 'package:get/get.dart';

// Kendi oluşturduğumuz controller'ı import ediyoruz
import 'package:flutterlearn/controlllers/user_controller.dart';

// ============================================
// VIEW SINIFI
// ============================================
// StatelessWidget kullanıyoruz çünkü:
// - GetX zaten state yönetimini yapıyor
// - StatefulWidget'a gerek yok
// - Daha temiz ve performanslı kod
class UserView extends StatelessWidget {
  UserView({super.key});

  // ============================================
  // CONTROLLER'I BAĞLAMA (DEPENDENCY INJECTION)
  // ============================================
  // Get.put() -> Controller'ı oluşturur ve hafızaya kaydeder
  //
  // Alternatifler:
  // - Get.put() -> Her zaman yeni instance oluşturur
  // - Get.find() -> Daha önce put edilmiş controller'ı bulur
  // - Get.lazyPut() -> İhtiyaç olunca oluşturur (lazy loading)
  //
  // Controller burada oluşturulduğu anda onInit() çalışır
  // ve getData() metodu API'den veri çekmeye başlar
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // Scaffold: Sayfa iskeleti (AppBar, Body, FloatingActionButton vs.)
    return Scaffold(
      // ============================================
      // APP BAR
      // ============================================
      appBar: AppBar(title: const Text("Personel Listesi")),

      // ============================================
      // BODY - ANA İÇERİK
      // ============================================
      // ⭐ Obx WIDGET'I ÇOK ÖNEMLİ!
      //
      // Obx ne yapar?
      // - İçindeki reaktif değişkenleri (.obs) dinler
      // - Değişken değiştiğinde otomatik rebuild yapar
      // - Sadece Obx içindeki widget'ı günceller (performanslı)
      //
      // Obx kullanmazsanız:
      // - isLoading veya userList değişse bile ekran güncellenmez!
      body: Obx(
        // ============================================
        // YÜKLEME DURUMU KONTROLÜ
        // ============================================
        // Ternary operator kullanıyoruz: koşul ? doğruysa : yanlışsa
        //
        // isLoading.value == true ise -> Loading spinner göster
        // isLoading.value == false ise -> Liste göster
        () => controller.isLoading.value
            // ⭐ YÜKLEME DURUMU: Ortada dönen bir spinner
            ? const Center(child: CircularProgressIndicator())
            // ⭐ VERİ GELDİ: Listeyi göster
            : ListView.builder(
                // Listede kaç eleman olacak?
                // controller.userList.length -> Listedeki kullanıcı sayısı
                itemCount: controller.userList.length,

                // ============================================
                // ITEM BUILDER - HER ELEMAN İÇİN
                // ============================================
                // Bu fonksiyon her liste elemanı için çağrılır
                // index: Elemanın sırası (0, 1, 2, ...)
                itemBuilder: (context, index) {
                  // O anki kullanıcıyı al
                  var currentUser = controller.userList[index];

                  // ============================================
                  // LIST TILE - LİSTE ELEMANI
                  // ============================================
                  // ListTile: Hazır liste görünümü widget'ı
                  // Icon, başlık, alt başlık ve tıklama içerir
                  return ListTile(
                    // Ana başlık: Kullanıcının adı
                    title: Text(currentUser.name),

                    // Alt başlık: Kullanıcı adı (username)
                    subtitle: Text(currentUser.username),

                    // Sol taraftaki ikon: ID'yi gösteren daire
                    leading: CircleAvatar(
                      // int'i String'e çeviriyoruz çünkü Text sadece String alır
                      child: Text(currentUser.id.toString()),
                    ),

                    // ============================================
                    // TIKLAMA OLAYINYI
                    // ============================================
                    // Kullanıcı bir elemana tıklarsa
                    onTap: () {
                      // ⭐ Get.to() ile sayfalar arası geçiş
                      //
                      // Avantajları:
                      // - context'e ihtiyaç yok
                      // - Animasyonlar otomatik
                      // - Veri aktarımı kolay
                      //
                      // Alternatifler:
                      // - Get.off() -> Mevcut sayfayı kapatır
                      // - Get.offAll() -> Tüm sayfaları kapatır
                      // - Get.back() -> Geri döner
                      Get.to(UserDetailView(user: currentUser));
                    },
                  );
                },
              ),
      ),
    );
  }
}
