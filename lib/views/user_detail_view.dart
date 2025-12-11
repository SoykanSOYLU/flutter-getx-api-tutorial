// ============================================
// KULLANICI DETAY SAYFASI
// ============================================
// Bu sayfa bir kullanıcının detaylı bilgilerini gösterir.
// Ana listeden tıklandığında bu sayfaya gelinir.
// Kullanıcı verisi parametre olarak alınır.

import 'package:flutter/material.dart';

// User modelini import ediyoruz çünkü parametre olarak alacağız
import 'package:flutterlearn/models/user_model.dart';

// ============================================
// DETAY VIEW SINIFI
// ============================================
// const constructor kullanabiliyoruz çünkü
// tüm değerler derleme zamanında biliniyor
class UserDetailView extends StatelessWidget {
  // ============================================
  // CONSTRUCTOR - VERİ AKTARIMI
  // ============================================
  // 'required this.user' -> Bu sayfa açılırken User nesnesi zorunlu
  //
  // Sayfa bu şekilde açılır:
  // Get.to(UserDetailView(user: secilenKullanici));
  //
  // Bu yöntemin avantajları:
  // - Tip güvenliği (type safety)
  // - Verinin mutlaka gelmesi garantili
  // - IDE otomatik tamamlama desteği
  const UserDetailView({super.key, required this.user});

  // Önceki sayfadan gelen kullanıcı verisi
  // final olduğu için değiştirilemez
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============================================
      // APP BAR - KULLANICININ ADI
      // ============================================
      // Başlıkta kullanıcının adını gösteriyoruz
      appBar: AppBar(
        title: Text(user.name),
        // Geri butonu otomatik eklenir (GetX sayesinde)
      ),

      // ============================================
      // BODY - KULLANICI BİLGİLERİ
      // ============================================
      body: Center(
        // Column: Widget'ları dikey olarak dizer
        child: Column(
          // Ortadan başla
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // E-posta adresi
            Text(user.email, style: const TextStyle(fontSize: 18)),

            // Boşluk
            const SizedBox(height: 10),

            // Kullanıcı adı
            Text(
              "@${user.username}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
