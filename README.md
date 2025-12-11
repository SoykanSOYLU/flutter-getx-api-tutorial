# 🚀 Flutter GetX ile API'den Veri Çekme Örneği

Bu proje, **Flutter** ve **GetX** kullanarak bir API'den nasıl veri çekileceğini, veriyi nasıl modelleyeceğinizi ve ekranda göstereceğinizi adım adım anlatan **eğitim amaçlı** bir uygulamadır.

## 📚 Ne Öğreneceksiniz?

- ✅ GetX state management kullanımı
- ✅ Dio ile HTTP GET isteği yapma
- ✅ JSON verisini Dart modeline çevirme
- ✅ Reaktif programlama (`.obs` ve `Obx`)
- ✅ Controller yapısı ve bağımlılık yönetimi
- ✅ Sayfalar arası veri geçişi

---

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                          # Uygulama giriş noktası
├── controllers/
│   └── user_controller.dart           # API çağrıları ve state yönetimi
├── models/
│   └── user_model.dart                # Kullanıcı veri modeli
└── views/
    ├── user_view.dart                 # Kullanıcı listesi ekranı
    └── user_detail_view.dart          # Kullanıcı detay ekranı
```

---

## 📦 Kullanılan Paketler

| Paket | Versiyon | Açıklama |
|-------|----------|----------|
| [get](https://pub.dev/packages/get) | ^4.6.5 | State management, routing, dependency injection |
| [dio](https://pub.dev/packages/dio) | ^5.1.0 | HTTP client (API istekleri için) |

---

## 🔧 Kurulum

1. **Projeyi klonlayın:**
   ```bash
   git clone <repository-url>
   cd fluttergetxgetdata
   ```

2. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

---

## 📖 Adım Adım Açıklama

### 1️⃣ Model Oluşturma (`user_model.dart`)

API'den gelen JSON verisini Dart nesnelerine çevirmek için bir model sınıfı oluşturuyoruz:

```dart
class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  // JSON'dan User nesnesine dönüştürme
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
```

### 2️⃣ Controller Oluşturma (`user_controller.dart`)

GetX Controller kullanarak state yönetimi ve API çağrılarını yapıyoruz:

```dart
class UserController extends GetxController {
  // Reaktif liste - değiştiğinde UI otomatik güncellenir
  var userList = <User>[].obs;
  var isLoading = false.obs;

  Future<void> getData() async {
    try {
      isLoading.value = true;
      
      var dio = Dio();
      var response = await dio.get("https://jsonplaceholder.typicode.com/users");

      if (response.statusCode == 200) {
        var gelenVeri = response.data as List;
        userList.value = gelenVeri.map((e) => User.fromJson(e)).toList();
      }
    } catch (e) {
      print("Hata: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData(); // Controller başlatıldığında veriyi çek
  }
}
```

### 3️⃣ View Oluşturma (`user_view.dart`)

Controller'ı view'a bağlayarak verileri gösteriyoruz:

```dart
class UserView extends StatelessWidget {
  // Controller'ı kaydet ve al
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personel Listesi")),
      body: Obx(
        // Obx: Reaktif değişkenler değiştiğinde otomatik rebuild
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.userList.length,
                itemBuilder: (context, index) {
                  var currentUser = controller.userList[index];
                  return ListTile(
                    title: Text(currentUser.name),
                    subtitle: Text(currentUser.username),
                    onTap: () => Get.to(UserDetailView(user: currentUser)),
                  );
                },
              ),
      ),
    );
  }
}
```

### 4️⃣ Main Dosyası (`main.dart`)

GetX'i kullanmak için `MaterialApp` yerine `GetMaterialApp` kullanıyoruz:

```dart
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserView(),
    );
  }
}
```

---

## 💡 Önemli Kavramlar

| Kavram | Açıklama |
|--------|----------|
| `.obs` | Değişkeni reaktif yapar. Değiştiğinde dinleyenler bilgilendirilir |
| `Obx()` | Reaktif değişkenleri dinler ve değiştiğinde widget'ı yeniden çizer |
| `Get.put()` | Controller'ı dependency injection ile kaydeder |
| `Get.to()` | Yeni sayfaya geçiş yapar |
| `GetxController` | State ve business logic'i yönetir |

---

## 🌐 API Bilgisi

Bu projede [JSONPlaceholder](https://jsonplaceholder.typicode.com/) ücretsiz fake API'si kullanılmaktadır.

**Endpoint:** `https://jsonplaceholder.typicode.com/users`

**Örnek Response:**
```json
[
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz"
  }
]
```

---

## 📱 Ekran Görüntüleri

| Ana Sayfa | Detay Sayfası |
|-----------|---------------|
| Kullanıcı listesi | Seçilen kullanıcının detayları |

---

## 🤝 Katkıda Bulunma

Bu proje eğitim amaçlıdır. Geliştirmek isterseniz:

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/yenilik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'i push edin (`git push origin feature/yenilik`)
5. Pull Request açın

---

## 📄 Lisans

Bu proje açık kaynaklıdır ve eğitim amaçlı kullanılabilir.

---

## 👨‍💻 Yazar - nakyoS

Eğitim ve öğretim amacıyla hazırlanmıştır.

**İyi kodlamalar!** 🎉
