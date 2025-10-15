BAŞLA

    // Kimlik Doğrulama
    YAZ "TC Kimlik Numaranızı giriniz:"
    OKU tc_kimlik
    YAZ "Şifrenizi giriniz:"
    OKU sifre

    EĞER kullanici_dogrula(tc_kimlik, sifre) DEĞİLSE
        YAZ "Kimlik doğrulama başarısız."
        DUR
    SON

    DÖNGÜ TRUE
        YAZ "Yapmak istediğiniz işlemi seçin:"
        YAZ "1 - Randevu Al"
        YAZ "2 - Tahlil Sonucu Görüntüle"
        YAZ "H - Çıkış"
        OKU islem_secimi

        EĞER islem_secimi = "1" İSE
            // --- Randevu Alma Modülü ---
            poliklinikler ← poliklinik_listesi_getir()
            YAZ "Poliklinikler:"
            YAZ poliklinikler
            YAZ "Poliklinik seçiniz:"
            OKU secilen_poliklinik

            doktorlar ← doktor_listesi_getir(secilen_poliklinik)
            YAZ "Doktorlar:"
            YAZ doktorlar
            YAZ "Doktor seçiniz:"
            OKU secilen_doktor

            saatler ← uygun_saatler_getir(secilen_doktor)
            EĞER saatler = boş İSE
                YAZ "Uygun saat bulunamadı. İşlem iptal edildi."
                DEVAM ET
            SON

            YAZ "Uygun saatler:"
            YAZ saatler
            YAZ "Randevu saati seçiniz:"
            OKU secilen_saat

            YAZ "Randevuyu onaylıyor musunuz? (E/H)"
            OKU onay
            EĞER onay = "E" VEYA onay = "e" İSE
                randevu_kaydet(tc_kimlik, secilen_doktor, secilen_saat)
                sms_gonder(tc_kimlik, secilen_doktor, secilen_saat)
                YAZ "Randevunuz başarıyla oluşturuldu ve SMS gönderildi."
            DEĞİLSE
                YAZ "Randevu iptal edildi."
            SON

        DEĞİLSE EĞER islem_secimi = "2" İSE
            // --- Tahlil Sonuçları Modülü ---
            tahliller ← tahlil_listesi_getir(tc_kimlik)
            EĞER tahliller = boş İSE
                YAZ "Kayıtlı tahlil sonucu bulunmamaktadır."
                DEVAM ET
            SON

            YAZ "Tahliller:"
            YAZ tahliller
            YAZ "Bir tahlil seçiniz:"
            OKU secilen_tahlil

            EĞER tahlil_sonucu_hazir_mi(secilen_tahlil) İSE
                sonuc ← tahlil_sonucu_getir(secilen_tahlil)
                YAZ "Tahlil Sonucu:"
                YAZ sonuc

                YAZ "Sonucu PDF olarak indirmek ister misiniz? (E/H)"
                OKU pdf_cevap
                EĞER pdf_cevap = "E" VEYA pdf_cevap = "e" İSE
                    pdf_olustur(secilen_tahlil)
                    YAZ "PDF indirildi."
                DEĞİLSE
                    YAZ "PDF indirimi iptal edildi."
                SON
            DEĞİLSE
                YAZ "Tahlil sonucu henüz hazır değil. Lütfen daha sonra tekrar deneyin."
            SON

        DEĞİLSE EĞER islem_secimi = "H" VEYA islem_secimi = "h" İSE
            YAZ "Sistemden çıkılıyor. İyi günler!"
            DUR

        DEĞİLSE
            YAZ "Geçersiz seçim. Lütfen tekrar deneyin."
        SON

    SONDÖNGÜ

BİTİR
