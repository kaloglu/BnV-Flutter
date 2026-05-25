# AGENTS.md

> ⚠️ **ÖNEMLİ KURAL — DİL:**
> Bu projede çalışan tüm AI ajanları (Hologram / Dreamflow Agent dahil) kullanıcıya **TÜM cevapları MUTLAKA Türkçe** olarak vermelidir.
> Kod içi değişken adları, sınıf adları ve teknik terimler İngilizce kalabilir; ancak **açıklamalar, özetler, hata mesajları, sorular ve yönlendirmeler Türkçe** olmalıdır.

---

## 1. Proje Özeti

**Proje Adı:** BnV — Ücretsiz Çekiliş Uygulaması

**Tek Cümleyle:** Kullanıcıların ücretsiz olarak katılabileceği günlük çekilişlerin düzenlendiği, kazananlara ürünlerin ücretsiz kargo ile gönderildiği bir mobil uygulamadır.

### 1.1. Konsept

- Uygulama sahibi (yayıncı), **sıfır veya ikinci el ürünleri, yiyecekleri, araçları** veya benzeri herhangi bir şeyi çekiliş olarak yayına alır.
- Belirlenen şartlar tamamlandığında, talep eden katılımcılar arasından seçilen kişi(ler)e ürün **ücretsiz kargo** ile gönderilir.
- Katılımcılardan **hiçbir ücret talep edilmez**. Uygulama tamamen ücretsizdir.

### 1.2. Katılım Hakkı Sistemi

- **Günlük Ücretsiz Hak:** Her kullanıcıya **her gün saat 09:00**'da otomatik olarak **1 (bir) katılım hakkı** tanımlanır.
- **Ek Haklar (Görevlerle Kazanılır):** Kullanıcılar ek katılım hakları kazanmak için çeşitli görevleri tamamlayabilir. Görevler ve ödüller dinamik olarak değişebilir. Örnekler (sadece örnektir, değişebilir):
  - 🎬 **Reklam İzleme:** Bir reklam izlenerek **+3 katılım hakkı** kazanılır.
  - 📱 **Sosyal Medya Paylaşımı:** Twitter / Instagram'da uygulamadan bahseden bir paylaşım yapılarak **+5 katılım hakkı** kazanılır.
  - 👥 **Arkadaş Davet Etme:** Davet edilen arkadaş uygulamaya katıldığında davet edene **+10 katılım hakkı** verilir.
- Görev sayısı, türü ve ödül miktarları **yapılandırılabilir** olmalıdır (hard-coded olmamalıdır).

---

## 2. Çalışan Ajanlar İçin Kritik Kurallar

### 2.1. Bozma! (Do Not Break!)

> 🛑 **Bu proje mevcut haliyle çalışır durumdadır. Çalışan kodu BOZMADAN devam ettir.**

- Mevcut dosya yapısını, mimari kararları ve isimlendirme kurallarını **koru**.
- Refactor önerilerini **kullanıcı açıkça istemedikçe yapma**.
- Var olan dosyaları silmeden / taşımadan önce **kullanıcıya sor**.
- Dependency (paket) sürümlerini kullanıcı istemeden güncelleme. Mevcut `pubspec.yaml` eski paket sürümleri içerebilir; bunlara dokunmadan önce kullanıcıya bilgi ver.

### 2.2. Cevap Dili

- ✅ **Türkçe** açıklama yap.
- ✅ Hata mesajlarını, log çıktılarını ve özet metinleri Türkçe yaz (kullanıcıya yönelik olanlar).
- ❌ İngilizce uzun açıklama **yazma**.
- 💬 Teknik kod / sınıf / değişken adları İngilizce kalabilir (Flutter ekosistem standardı).

### 2.3. Görev Tamamlama

- Yapılan değişikliklerden sonra `compile_project` aracı ile hata kontrolü yap.
- Değişiklik özetini **2–4 kısa Türkçe cümle** ile aktar; dosya dosya detay verme.

---

## 3. Mimari ve Klasör Yapısı

```
lib/
├── main.dart                  # Uygulama giriş noktası, Firebase init
├── BnvApp.dart                # Kök uygulama widget'ı
├── firebase_options.dart      # FlutterFire CLI ile üretilen Firebase config
│
├── app/
│   ├── app_router.dart        # Route tanımları
│   └── top_level_providers.dart  # Riverpod global provider'lar
│
├── constants/                 # Renkler, stil, sabitler, enum'lar
│
├── data/
│   └── services/              # Firebase Auth, Firestore, SharedPreferences, Notifications
│
├── models/                    # Veri modelleri (User, Raffle, Ticket, Attendee, ...)
│
├── ui/
│   ├── screens/               # Sayfa seviyesinde widget'lar (raffles, home, auth, profile, onboarding)
│   └── widgets/               # Tekrar kullanılabilir widget'lar (raffle, auth, common)
│
└── utils/
    ├── firebase/              # Firestore yardımcı sınıfları (Collection, Document, helper)
    └── AppAds.dart            # Reklam entegrasyonu
```

### 3.1. State Management

- **Riverpod** (`hooks_riverpod`) kullanılmaktadır. `top_level_providers.dart` içindeki provider'ları temel al.

### 3.2. Backend

- **Firebase** (Authentication + Firestore + Cloud Messaging) bağlı.
- Firestore yolları için `lib/data/services/firestore_path.dart` dosyasındaki sabit yol fonksiyonlarını kullan; yeni yolları orada tanımla.
- Firestore kurallarını (`firestore.rules`) ve index'leri (`firestore.indexes.json`) güncellerken Firebase paneli üzerinden deploy edilmesi gerektiğini kullanıcıya hatırlat.

---

## 4. Temel Veri Modelleri (Mevcut)

| Model | Dosya | Açıklama |
|---|---|---|
| `UserModel` | `lib/models/user_model.dart` | Kullanıcı bilgileri |
| `RaffleModel` | `lib/models/raffle_model.dart` | Çekiliş kaydı |
| `RaffleRulesModel` | `lib/models/raffle_rules_model.dart` | Çekiliş kuralları |
| `TicketModel` | `lib/models/ticket_model.dart` | Katılım bileti / hak |
| `AttendeeModel` | `lib/models/attendee_model.dart` | Çekilişe katılan kullanıcı |
| `EnrollModel` | `lib/models/enroll_model.dart` | Kayıt / katılım bilgisi |
| `ProductInfoModel` | `lib/models/product_info_model.dart` | Çekilişteki ürün bilgisi |
| `MediaModel` | `lib/models/media_model.dart` | Medya (görsel/video) |

> Yeni model eklerken `BaseModel` (`lib/models/base/base_model.dart`) yapısına ve `toJson` / `fromJson` / `copyWith` desenine uy. `createdAt` ve `updatedAt` alanlarını ekle.

---

## 5. Eklenmesi Planlanan / Gelecek Özellikler

Aşağıdaki özellikler henüz tamamlanmamış olabilir; geliştirme yaparken bu yol haritasını dikkate al:

- [ ] **Günlük 09:00 ücretsiz hak otomatik tanımlama** (Cloud Function / scheduled trigger)
- [ ] **Görev sistemi (Tasks)**: dinamik yapılandırılabilir görev modeli (reklam izleme, sosyal paylaşım, arkadaş daveti vb.)
- [ ] **Reklam entegrasyonu** ile hak kazanma (`AppAds.dart` mevcut, görev sistemi ile bağlanmalı)
- [ ] **Davet / referans sistemi** (referral code)
- [ ] **Kazanan seçim algoritması** (rastgele, adil)
- [ ] **Kargo / teslimat takibi**
- [ ] **Push bildirimleri** (çekiliş başlangıcı, kazanan duyurusu, günlük hak hatırlatması)

---

## 6. Geliştirme İpuçları

- Renk ve stil sabitlerini **`lib/constants/`** içinden referans ver; widget içinde sabit renk değeri yazma.
- Hata loglamak için `debugPrint()` kullan (`package:flutter/foundation.dart`).
- Cross-platform (Android, iOS, Web) uyumluluğu koru — `dart:io` yerine `file_picker` gibi paketleri tercih et.
- UI metinleri Türkçe olmalıdır (uygulama Türk kullanıcılara yönelik).

---

## 7. Hatırlatma

> 🇹🇷 **Kullanıcıya verilen TÜM cevaplar Türkçe olacaktır. Bu kural istisnasızdır.**
