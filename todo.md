# To-Do

Bu liste kolaydan zora göre kategorize edilmiştir. Tamamlanan maddeler işaretlidir.

## 1) Acil: Derlenebilirlik ve Çalıştırma
- [x] Firebase yapılandırması ve `firebase_options.dart` doğrulaması (BNV-001)
- [x] `app_router.dart` rotaları ve `top_level_providers.dart` derleme/doğrulama turu (BNV-002)
- [x] Android/iOS manifest izinleri ve minimum/target SDK ayarlarının gözden geçirilmesi (BNV-003)
- [ ] Null-safety kritik uyum paketi: modeller, eski UI butonları, Riverpod v2 geçişi (BNV-004)
  - [x] Modeller ve generated kod null-safety uyumu (freezed/json) (BNV-004A)
  - [x] UI buton bileşenlerinin null-safety ve tema uyumu (BNV-004B)
  - [ ] Riverpod v2 uyumluluk katmanı ve minimal geçiş (BNV-004C)
  - [ ] Firebase Messaging/Notifications geçici uyumluluk ve fallback (BNV-004D)
  - [ ] Duman testi: Auth→Raffles→Detail→Enroll akışı ve log gözden geçirme (BNV-004E)
  - [x] Web derleme: carousel_slider isim çakışması için geçici PageView fallback (BNV-004F)

## 2) Bağımlılıklar ve Paket Yönetimi
- [x] Eski AdMob entegrasyonu kaldırıldı (BNV-101)
- [ ] Google Mobile Ads (AdMob) yeniden entegrasyonu ve test reklamlarıyla doğrulama (BNV-102)
- [ ] Pubspec sürümlerinin "optimum, stabil" aralıklara sabitlenmesi (kapsamlı tarama) (BNV-103)

## 3) Özellikler ve Backend Entegrasyonları
- [ ] Görev (Tasks) sistemi: kazanım kuralları, ödüller, esnek konfigürasyon (BNV-201)
- [ ] Günlük 09:00 ücretsiz hak: zamanlanmış Cloud Function ve idempotent dağıtım (BNV-202)
- [ ] Davet/referral sistemi: kod üretimi, kabul akışı, ödül hakları (BNV-203)
- [ ] Kazanan seçim algoritması: adil, tekrarlanabilir ve şeffaf seçim (BNV-204)
- [ ] Push bildirimleri: başlangıç, kazanan duyurusu, günlük hatırlatma (BNV-205)
- [ ] Kargo/takip akışı: durum güncellemeleri ve kullanıcı bilgilendirmeleri (BNV-206)
- [ ] Raffles listesi performans/paginasyon iyileştirmeleri (BNV-207)

## 4) Veri Modelleri ve Servisler
- [ ] Modellerde `createdAt`/`updatedAt` alanlarının doğrulanması/eklenmesi; `toJson`/`fromJson` uyumu (BNV-301)
- [ ] Firestore path sabitlerinin güncellenmesi, yeni yolların `data/firestore_path.dart` içine eklenmesi (BNV-302)
- [ ] `RaffleRepository` ve `UserRepository` akışlarının gözden geçirilmesi (BNV-303)

## 5) UI/UX
- [ ] Onboarding akışı ile görev/hak kazanımı entegrasyonu (BNV-401)
- [ ] Uygulama içi tüm metinlerin Türkçe bütünlük kontrolü (BNV-402)
- [ ] Tema ve dark mode ince ayarları; sabit renklerin constants üzerinden kullanımı (BNV-403)

## 6) Test, Debug ve Operasyon
- [ ] Kritik akışlara `debugPrint` tabanlı hata/log noktalarının eklenmesi (BNV-501)
- [ ] Firestore güvenlik kuralları ve index’lerin gözden geçirilmesi (BNV-502)
- [x] `AGENTS.md` eklendi ve dil/işleyiş kuralları işlendi (BNV-503)
- [x] `todo.md` ve `dev_notes.md` oluşturuldu (BNV-504)
