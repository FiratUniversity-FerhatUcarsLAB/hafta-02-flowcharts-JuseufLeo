BAŞLA // 1. Kullanıcı Girişi

    YAZ "Kullanıcı adı giriniz:"
    OKU kullanici_adi
    YAZ "Şifre giriniz:"
    OKU sifre

    EĞER sistemde_kayıtlı(kullanici_adi, sifre) İSE
        YAZ "Giriş başarılı"
    DEĞİLSE
        YAZ "Hatalı giriş. Lütfen tekrar deneyin."
        DUR
    SON

BİTİR


BAŞLA // 2. Ürün Ekleme ve Stok Kontrolü

    DÖNGÜ TRUE TEKRAR
        YAZ "Ürün ID giriniz (Çıkmak için 0):"
        OKU urun_id

        EĞER urun_id = 0 İSE
            ÇIK
        SON

        YAZ "Kaç adet eklemek istiyorsunuz?"
        OKU miktar

        EĞER stok_yeterli_mi(urun_id, miktar) İSE
            sepet ← sepet + {urun_id, miktar}
            YAZ "Ürün sepete eklendi."
        DEĞİLSE
            YAZ "Yetersiz stok."
        SON

    SONDÖNGÜ

BİTİR


BAŞLA // 3. İndirim Kodu Uygulama

    YAZ "İndirim kodunuz varsa giriniz (yoksa boş bırakın):"
    OKU indirim_kodu

    EĞER indirim_kodu ≠ "" İSE
        EĞER kod_gecerli_mi(indirim_kodu) İSE
            indirim_orani ← kodu_al(indirim_kodu)
            toplam_tutar ← toplam_tutar * (1 - indirim_orani)
            YAZ "İndirim uygulandı: ", indirim_orani * 100, "%"
        DEĞİLSE
            YAZ "İndirim kodu geçersiz."
        SON
    SON

BİTİR


BAŞLA // 4. Kargo Hesaplama

    YAZ "Kargo adresinizi girin:"
    OKU adres

    kargo_ucreti ← kargo_hesapla(adres, sepet)

    toplam_tutar ← toplam_tutar + kargo_ucreti

    YAZ "Kargo ücreti: ", kargo_ucreti
    YAZ "Toplam ödenecek tutar: ", toplam_tutar

BİTİR


BAŞLA // 5. Ödeme Aşaması

    YAZ "Ödeme yöntemini seçin: (1) Kredi Kartı (2) Havale (3) Kapıda Ödeme"
    OKU odeme_secimi

    EĞER odeme_secimi = 1 İSE
        YAZ "Kart bilgilerini giriniz:"
        OKU kart_no, son_kullanma, cvv

        EĞER kart_gecerli_mi(kart_no, son_kullanma, cvv) İSE
            ödeme_başarılı ← kredi_karti_cek(kart_no, toplam_tutar)
        DEĞİLSE
            YAZ "Kart bilgileri geçersiz."
            DUR
        SON

    DEĞİLSE EĞER odeme_secimi = 2 İSE
        YAZ "Havale için banka bilgileri gönderildi."
        ödeme_başarılı ← TRUE

    DEĞİLSE EĞER odeme_secimi = 3 İSE
        YAZ "Kapıda ödeme seçildi. Sipariş onaylandı."
        ödeme_başarılı ← TRUE

    DEĞİLSE
        YAZ "Geçersiz seçim."
        DUR
    SON

    EĞER ödeme_başarılı İSE
        stok_guncelle(sepet)
        siparis_olustur(kullanici_adi, sepet, toplam_tutar)
        YAZ "Ödeme başarılı, siparişiniz oluşturuldu."
    DEĞİLSE
        YAZ "Ödeme başarısız. Lütfen tekrar deneyin."
    SON

BİTİR
