# Sistem sonsuz döngüde çalışır
while True:  # DOĞRU koşulu ile sonsuz döngü

    # 1. Tüm sensörleri oku
    hareket_var = hareket_sensor_okuma()
    kapi_pencere_acik = kapi_pencere_sensor_okuma()
    
    # 2. Tehdit durumu kontrolü
    if hareket_var or kapi_pencere_acik:
        
        # Kamera aktivasyonu kontrolü (isteğe bağlı)
        if kamera_aktif_mi():
            kamera_aktivasyonu_yap()
        
        # Yanlış alarm kontrolü (ev sahibi evde mi?)
        if ev_sahibi_evde_mi():
            alarm_sifirla()
            continue  # Döngü başına dön
        
        # 3. Alarm seviyesi belirle
        if hareket_var and kapi_pencere_acik:
            alarm_seviyesi = 3  # Yüksek alarm
        elif hareket_var or kapi_pencere_acik:
            alarm_seviyesi = 2  # Orta alarm
        else:
            alarm_seviyesi = 1  # Düşük alarm (gerekirse)
        
        # 4. Alarmı aktif et ve bildirim gönder
        alarm_ac(alarm_seviyesi)
        bildirim_gonder(alarm_seviyesi)
        
        # 5. Alarm sıfırlanana kadar döngüyü devam ettir
        while not alarm_sifirlama_komutu_geldi():
            bekle_bir_sure()
        
        alarm_sifirla()
    
    else:
        # Tehdit yok, bekle ve sensörleri tekrar oku
        bekle_bir_sure()
