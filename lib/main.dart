// ============================================
// FLUTTER GETX İLE API'DEN VERİ ÇEKME ÖRNEĞİ
// ============================================
// Bu dosya uygulamanın giriş noktasıdır (entry point)
// Uygulama buradan başlar ve çalışır

// Flutter'ın temel Material Design widget'larını içerir
import 'package:flutter/material.dart';

// Kendi oluşturduğumuz ana sayfa view'ını import ediyoruz
import 'package:flutterlearn/views/user_view.dart';

// ⭐ ÖNEMLİ: GetX paketini import ediyoruz
// GetX bize şunları sağlar:
// - State Management (durum yönetimi)
// - Route Management (sayfa yönetimi)
// - Dependency Injection (bağımlılık enjeksiyonu)
import 'package:get/get.dart';

// ============================================
// UYGULAMAYI BAŞLATAN FONKSİYON
// ============================================
void main() {
  // runApp() Flutter'ın uygulamayı başlatan fonksiyonudur
  // İçine root widget'ı (ana widget) veriyoruz
  runApp(const MainApp());
}

// ============================================
// ANA UYGULAMA WIDGET'I
// ============================================
// StatelessWidget: Durumu değişmeyen widget
// Ana uygulama widget'ı genellikle StatelessWidget olur
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ⭐ ÖNEMLİ: MaterialApp yerine GetMaterialApp kullanıyoruz!
    //
    // Neden GetMaterialApp?
    // - GetX'in tüm özelliklerini kullanabilmek için
    // - Get.to(), Get.back() gibi navigasyon metodları için
    // - Snackbar, Dialog, BottomSheet için
    // - Dependency injection için
    //
    // Eğer normal MaterialApp kullanırsanız GetX çalışmaz!
    return GetMaterialApp(
      // Debug bandını kaldırır (sağ üstteki "DEBUG" yazısı)
      debugShowCheckedModeBanner: false,

      // Uygulama açıldığında gösterilecek ilk sayfa
      // UserView() bizim oluşturduğumuz kullanıcı listesi sayfası
      home: UserView(),
    );
  }
}
