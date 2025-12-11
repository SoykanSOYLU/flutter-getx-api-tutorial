// ============================================
// KULLANICI CONTROLLER - STATE YÖNETİMİ
// ============================================
// Bu dosya uygulamanın "beyni" gibidir.
// API'den veri çeker, verileri saklar ve yönetir.
// View (arayüz) bu controller'ı dinler ve değişikliklere göre güncellenir.

// Dio: HTTP istekleri yapmak için kullanılan popüler bir paket
// http paketinden daha güçlü ve esnek
import 'package:dio/dio.dart';

// Kendi oluşturduğumuz User modeli
import 'package:flutterlearn/models/user_model.dart';

// GetX paketi - State management için
import 'package:get/get.dart';

// ============================================
// GETX CONTROLLER SINIFI
// ============================================
// GetxController'dan extend ediyoruz (miras alıyoruz)
// Bu bize şunları sağlar:
// - Lifecycle metodları (onInit, onReady, onClose)
// - Reaktif değişkenler (.obs)
// - Otomatik bellek yönetimi
class UserController extends GetxController {
  // ============================================
  // REAKTİF DEĞİŞKENLER (.obs)
  // ============================================
  // '.obs' (observable) eklediğimizde değişken "reaktif" olur
  // Yani değiştiğinde dinleyenler (Obx widget'ları) otomatik güncellenir
  //
  // <User>[] boş bir User listesi oluşturur
  // .obs bunu reaktif yapar
  var userList = <User>[].obs;

  // Yükleniyor durumunu takip eden değişken
  // true iken loading spinner göstereceğiz
  // false olunca listeyi göstereceğiz
  var isLoading = false.obs;

  // ============================================
  // API'DEN VERİ ÇEKEN FONKSİYON
  // ============================================
  // Future<void>: Bu fonksiyon asenkron çalışır (async)
  // Yani interneti beklerken uygulama donmaz
  Future<void> getData() async {
    // try-catch-finally yapısı hata yönetimi için kullanılır
    try {
      // ⭐ 1. ADIM: Yükleniyor durumunu aç
      // isLoading.value ile reaktif değişkenin değerini değiştiriyoruz
      // .value kullanmak zorunlu! Direkt isLoading = true yapamazsın
      isLoading.value = true;

      // ⭐ 2. ADIM: Dio nesnesi oluştur
      // Dio HTTP istekleri yapmak için kullanılır
      var dio = Dio();

      // ⭐ 3. ADIM: GET isteği at ve cevabı bekle
      // await: Bu satır bitene kadar bekle demek
      // dio.get(): HTTP GET isteği atar
      // JSONPlaceholder: Ücretsiz test API'si (fake data sağlar)
      var response = await dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );

      // ⭐ 4. ADIM: Cevap başarılı mı kontrol et
      // HTTP 200 = Her şey yolunda, veri geldi
      // HTTP 404 = Sayfa bulunamadı
      // HTTP 500 = Sunucu hatası
      if (response.statusCode == 200) {
        // ⭐ 5. ADIM: Gelen veriyi List'e çevir
        // API'den gelen veri dynamic tipinde
        // Biz bunun bir liste olduğunu biliyoruz, o yüzden cast ediyoruz
        var gelenVeri = response.data as List;

        // ⭐ 6. ADIM: Eski verileri temizle
        // Tekrar çağrıldığında eski veriler üzerine eklenmemesi için
        userList.clear();

        // ⭐ 7. ADIM: JSON verisini User modellerine dönüştür
        // .map() -> Listedeki her elemanı dönüştürür
        // (e) -> Her bir JSON objesi
        // User.fromJson(e) -> JSON'ı User nesnesine çevirir
        // .toList() -> Sonucu tekrar listeye çevirir
        //
        // Örnek akış:
        // [{"id":1, "name":"Ali"}, {"id":2, "name":"Veli"}]
        //    ↓ map ile dönüştür
        // [User(id:1, name:"Ali"), User(id:2, name:"Veli")]
        userList.value = gelenVeri.map((e) => User.fromJson(e)).toList();
      }
    } catch (e) {
      // ⭐ HATA YAKALAMA
      // İnternet yoksa, API çalışmıyorsa vs. buraya düşer
      // Gerçek uygulamada kullanıcıya güzel bir hata mesajı gösterilmeli
      print("Hata çıktı: $e");
    } finally {
      // ⭐ FINALLY: Her durumda çalışır (hata olsa da olmasa da)
      // Yükleniyor durumunu kapat
      // Bu sayede loading spinner kaybolur
      isLoading.value = false;
    }
  }

  // ============================================
  // LIFECYCLE METODLARI
  // ============================================
  // onInit(): Controller ilk oluşturulduğunda çağrılır
  // Burada ilk veri çekme işlemini yapıyoruz
  @override
  void onInit() {
    super.onInit(); // Üst sınıfın onInit'ini çağır (zorunlu)

    // Controller oluşturulduğunda otomatik olarak veriyi çek
    // Böylece kullanıcı uygulamayı açtığında direkt veri gelir
    getData();
  }

  // Diğer lifecycle metodları:
  // onReady(): Widget tamamen hazır olduğunda çağrılır
  // onClose(): Controller yok edilirken çağrılır (temizlik için)
}
