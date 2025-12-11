// ============================================
// KULLANICI (USER) VERİ MODELİ
// ============================================
// Bu dosya API'den gelen JSON verisini Dart nesnesine
// dönüştürmek için kullanılır.
//
// API'den gelen örnek JSON:
// {
//   "id": 1,
//   "name": "Leanne Graham",
//   "username": "Bret",
//   "email": "Sincere@april.biz"
// }
//
// Bu JSON'ı Dart'ta kullanabilmek için bir Model sınıfı oluşturuyoruz

class User {
  // ============================================
  // SINIF DEĞİŞKENLERİ (PROPERTIES)
  // ============================================
  // 'final' demek: Bu değer bir kez atandıktan sonra değiştirilemez
  // API'den gelen veri genellikle değişmez, bu yüzden final kullanıyoruz

  final int id; // Kullanıcının benzersiz numarası
  final String name; // Kullanıcının tam adı
  final String username; // Kullanıcının kullanıcı adı
  final String email; // Kullanıcının e-posta adresi

  // ============================================
  // CONSTRUCTOR (YAPICI METOD)
  // ============================================
  // Bu constructor ile User nesnesi oluşturuyoruz
  // 'required' demek: Bu parametre zorunlu, boş bırakılamaz
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  // ============================================
  // FACTORY CONSTRUCTOR - JSON'DAN NESNE OLUŞTURMA
  // ============================================
  // 'factory' keyword'ü: Özel bir constructor türü
  // JSON Map'inden User nesnesi oluşturur
  //
  // Parametre tipi: Map<String, dynamic>
  // - String: JSON'daki anahtar (key) isimleri ("id", "name" vs.)
  // - dynamic: Değer herhangi bir tip olabilir (int, String vs.)
  //
  // Kullanım örneği:
  // var user = User.fromJson({"id": 1, "name": "Ali"});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // json['id'] -> JSON'dan "id" anahtarının değerini al
      id: json['id'],

      // json['name'] -> JSON'dan "name" anahtarının değerini al
      name: json['name'],

      // json['username'] -> JSON'dan "username" anahtarının değerini al
      username: json['username'],

      // json['email'] -> JSON'dan "email" anahtarının değerini al
      email: json['email'],
    );
  }
}
