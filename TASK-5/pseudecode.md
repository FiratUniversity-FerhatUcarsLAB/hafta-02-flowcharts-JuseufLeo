BAŞLA

DÖNGÜ (DOĞRU)
    // Sistem aktif mi?
    EĞER sistem_aktif_mi() = HAYIR İSE
        BEKLE(1 saniye)
        DEVAM ET
    SON

    // Tüm sensörleri oku
    hareket_algilandi ← hareket_sensor_oku()
    kapi_pencere_acildi ← kapi_pencere_sensor_oku()
    cam_kirildi ← cam_kirildi_sensor_oku()
    // İstenirse başka sensörler eklenebilir

    // Tehdit seviyesi belirle
    tehdit_seviyesi ← 0
    EĞER hareket_algilandi = EVET VE kapi_pencere_acildi = EVET VE cam_kirildi = EVET İSE
        tehdit_seviyesi ← 3   // Yüksek
    DEĞİLSE EĞER hareket_algilandi = EVET VE (kapi_pencere_acildi = EVET VEYA cam_kirildi = EVET) İSE
        tehdit_seviyesi ← 2   // Orta
    DEĞİLSE EĞER hareket_algilandi = EVET VE kapi_pencere_acildi = HAYIR VE cam_kirildi = HAYIR İSE
        tehdit_seviyesi ← 1   // Düşük
    SON

    // Yanlış alarm kontrolü
    ev_sahibi_evde ← ev_sahibi_durumu()
    EĞER ev_sahibi_evde = EVET İSE
        tehdit_seviyesi ← 0   // Yanlış alarm önleme
    SON

    // Alarm ve bildirim işlemleri
    EĞER tehdit_seviyesi = 0 İSE
        alarm_sistemi_kapat()
    DEĞİLSE
        alarm_seviyesi_ayarla(tehdit_seviyesi)
        alarm_ver()
        SMS_gonder(tehdit_seviyesi)
        App_bildirim_gonder(tehdit_seviyesi)
        Email_gonder(tehdit_seviyesi)
    SON

    // Alarm sıfırlama kontrolü
    EĞER alarm_sifirlandi_mi() = EVET İSE
        alarm_sistemi_kapat()
        BEKLE(5 saniye)
        DEVAM ET
    SON

    BEKLE(5 saniye)
SONDÖNGÜ

BİTİR
