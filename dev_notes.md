# Dev Notes

Her yapılacak madde için referans kodu ve kısa teknik notlar.

- BNV-001: Firebase yapılandırması doğrulandı. `lib/firebase_options.dart` mevcut, `main.dart` içinde init akışı sorunsuz. Etki: Girişte hata beklenmiyor. Geriye dönük not: Proje/ortam değişirse FlutterFire CLI ile yeniden üret.

- BNV-002: `app_router.dart` ve `top_level_providers.dart` için derleme/doğrulama turu yapılacak. Etki: Rotada kırık isimler/parametreler tespit edilirse, ekran açılışları etkilenir. Plan: Rota isimlerini ve argüman tiplerini tek tek derleme uyarıları üzerinden düzelt, test navigasyon akışları hazırla.

- BNV-003: Android/iOS manifest ve min/target SDK ayarları kontrol edilecek. Etki: Derleme/red riski. Plan: AndroidManifest izinleri (INTERNET, POST_NOTIFICATIONS vb.), iOS Info.plist açıklamaları (ATT vs.) gözden geçirilecek.

- BNV-101: Eski AdMob entegrasyonu kaldırıldı. Etki: Uygulamada reklam gösterimi ve reklam izleyerek hak kazanımı şu an devre dışı. Geri ekleme planı BNV-102'de.

- BNV-102: Google Mobile Ads (AdMob) yeniden entegrasyonu. Plan: `google_mobile_ads` paketi eklenecek, `AppAds.dart` tek giriş noktası olarak tasarlanacak. `MobileAds.instance.initialize()` uygulama açılışında yapılacak. Ödüllü reklam (rewarded) ve interstitial gösterimleri görev sistemiyle tetiklenecek. Test ID’leri ile doğrulandıktan sonra gerçek ID’ler gizli yapılandırmadan beslenecek. iOS için ATT izin akışı ve kullanıcı aksiyonu gereklilikleri eklenecek. Hata durumları `debugPrint` ile loglanacak.

- BNV-103: Pubspec sürümleri "optimum, stabil" seviyelere sabitlenecek. Plan: Firebase ve Riverpod için takımca onaylı sürüm seti belirlenecek, major yükseltmelerden kaçınılacak; yalnızca uyumluluk için gereken min güncellemeler yapılacak.

- BNV-201: Görev (Tasks) sistemi. Plan: Görev modeli (tip, ödül, limit, doğrulama stratejisi) oluştur; Firestore'da konfig yazılabilir yap. UI: Görev listesi + detay + tamamla akışı. Güvenlik: Kullanıcı başına hak artışı idempotent.

- BNV-202: Günlük 09:00 ücretsiz hak. Plan: Cloud Functions ile zamanlanmış tetikleyici (per region) kur; kullanıcı başına hak sayısını atomik artır; retry/idempotency ekle. Kullanıcı tarafında bir özet sayaç göster.

- BNV-203: Davet/referral. Plan: Referral code üretimi, paylaşma linki, ilk girişte kod doğrulama; hem davet eden hem edilen için hak tanımı. Sahtekarlık önleme için cihaz/oturum kontrolleri.

- BNV-204: Kazanan seçim algoritması. Plan: Çekiliş kapanışında server-side rastgele seçim, seed/log saklama, denetlenebilirlik için audit trail; tekrar seçim ve diskalifiye işleyişi.

- BNV-205: Push bildirimleri. Plan: FCM token kaydı, izin akışları; konulara göre (raffle_start, winner_announce, daily_reminder) gönderim; sessiz saat kuralları.

- BNV-206: Kargo/takip akışı. Plan: Gönderim bilgileri, durum güncellemeleri (hazırlanıyor, kargoda, teslim edildi); kullanıcı bildirimi; opsiyonel kargo entegrasyonu.

- BNV-207: Raffles liste performans/paginasyon. Plan: Sorgu limiti + startAfter ile sayfalama; shimmer/placeholder; scroll yeniden girişte kaldığı yerden devam.

- BNV-301: Modellerde `createdAt`/`updatedAt`. Plan: `BaseModel` üzerinden tüm modellere alan doğrulaması; `Timestamp`/`DateTime` dönüşümleri; `copyWith` uyum testleri. Bozuk kayıtlar için toleranslı decode.

- BNV-302: Firestore path sabitleri. Plan: Yeni koleksiyon/doküman yolları yalnızca `lib/data/firestore_path.dart` üzerinden tanımlansın; doğrudan string kullanılmasın. Kod araması ile kaçak kullanımlar temizlenecek.

- BNV-303: Repositories gözden geçirme. Plan: `RaffleRepository` ve `UserRepository` çağrı sözleşmelerini netleştir; hataları `debugPrint` ile logla; null güvenli akışlar.

- BNV-401: Onboarding x Görev entegrasyonu. Plan: Onboarding sonunda görev öneri kartları; hak sayacı bağlama; başarı durumunda görsel geri bildirim.

- BNV-402: Türkçe metin bütünlüğü. Plan: Ekranlardaki sabit metinlerin taranması; i18n gerekirse `intl` ile altyapı; tutarlı terminoloji.

- BNV-403: Tema/Dark Mode. Plan: Tüm renk/stil sabitlerini `constants` üzerinden kullanma denetimi; kontrast ve erişilebilirlik kontrolü; ikon/metin kontrastı.

- BNV-501: `debugPrint` log noktaları. Plan: Hata yakalanan bloklarda anlamlı bağlam mesajları; kullanıcıya gösterilen hata ile log ayrımı; PII sızıntısını engelle.

- BNV-502: Firestore kurallar/index'leri. Plan: Okuma/yazma kuralları minimum ayrıcalıkla; sorgu için gerekli bileşik index'ler; Firebase panelinden deploy.

- BNV-503: `AGENTS.md` eklendi. Not: Tüm cevapların Türkçe olması zorunlu kuralı işlendi; mimari ve klasör yapısı referans için sabitlendi.

- BNV-504: `todo.md` ve `dev_notes.md` oluşturuldu. Not: Bu iki dosya proje operasyonu ve izlenebilirlik için tek referans noktası olarak kullanılacak; her değişiklikte güncellenecek.
