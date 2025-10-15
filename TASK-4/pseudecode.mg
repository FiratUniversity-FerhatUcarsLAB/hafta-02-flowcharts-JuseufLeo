BAŞLA

    // Öğrenci Girişi
    YAZ "Öğrenci No giriniz:"
    OKU ogrenci_no
    YAZ "Şifre giriniz:"
    OKU sifre

    EĞER ogrenci_dogrula(ogrenci_no, sifre) DEĞİLSE
        YAZ "Giriş başarısız."
        DUR
    SON

    toplam_kredi ← 0
    secilen_dersler ← boş liste

    DÖNGÜ
        ders_listesi ← dersleri_getir()
        YAZ "Mevcut Dersler:"
        YAZ ders_listesi

        YAZ "Bir ders seçiniz veya çıkmak için 'Ç' giriniz:"
        OKU ders_secimi

        EĞER ders_secimi = "Ç" VEYA ders_secimi = "ç" İSE
            YAZ "Kayıt özeti:"
            YAZ secilen_dersler
            YAZ "Toplam kredi: ", toplam_kredi
            YAZ "Kaydı onaylıyor musunuz? (E/H)"
            OKU onay
            EĞER onay = "E" VEYA onay = "e" İSE
                YAZ "Kayıt başarıyla tamamlandı."
            DEĞİLSE
                YAZ "Kayıt iptal edildi."
            SON
            DUR
        SON

        ders ← ders_bilgisi_getir(ders_secimi)

        // Kontenjan kontrolü
        EĞER ders.kontenjan_doldu_mu() İSE
            YAZ "Dersin kontenjanı dolu."
            DEVAM ET
        SON

        // Ön koşul kontrolü
        EĞER NOT_ONKOŞUL_DERSLERİ_BASARILI_MI(ogrenci_no, ders.onkosul_dersler) DEĞİLSE
            YAZ "Ön koşul dersleri tamamlanmamış."
            DEVAM ET
        SON

        // Zaman çakışması kontrolü
        EĞER zaman_cakisiyor_mu(secilen_dersler, ders) İSE
            YAZ "Dersin zamanında çakışma var."
            DEVAM ET
        SON

        // Kredi limiti kontrolü
        EĞER toplam_kredi + ders.kredi > 35 İSE
            YAZ "Kredi limiti aşılıyor."
            DEVAM ET
        SON

        // Danışman onayı kontrolü (GPA < 2.5 ise)
        gpa ← ogrenci_gpa_getir(ogrenci_no)
        EĞER gpa < 2.5 İSE
            YAZ "Danışman onayı gerekiyor. Onay alındı mı? (E/H)"
            OKU onay
            EĞER onay ≠ "E" VEYA onay ≠ "e" İSE
                YAZ "Danışman onayı alınmadı."
                DEVAM ET
            SON
        SON

        // Ders ekleme
        secilen_dersler.ekle(ders)
        toplam_kredi ← toplam_kredi + ders.kredi
        YAZ "Ders eklendi: ", ders.adi
        YAZ "Toplam kredi: ", toplam_kredi

        // Ders çıkarma seçeneği
        YAZ "Ders çıkarma yapmak ister misiniz? (E/H)"
        OKU cevap
        EĞER cevap = "E" VEYA cevap = "e" İSE
            YAZ "Çıkarmak istediğiniz dersi seçiniz:"
            OKU ders_cikar
            EĞER ders_cikar mevcut ise secilen_dersler İSE
                secilen_dersler.cikar(ders_cikar)
                toplam_kredi ← toplam_kredi - ders_cikar.kredi
                YAZ "Ders çıkarıldı: ", ders_cikar.adi
                YAZ "Toplam kredi: ", toplam_kredi
            DEĞİLSE
                YAZ "Seçilen ders kayıtlı değil."
            SON
        SON

    SONDÖNGÜ

BİTİR
