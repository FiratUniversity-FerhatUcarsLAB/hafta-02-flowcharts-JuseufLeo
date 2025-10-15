BAŞLA

    // Sabitler ve başlangıç değerleri
    PIN_KODU ← 1234
    GÜNLÜK_LİMİT ← 2000
    bakiye ← 5000
    günlük_çekilen ← 0
    pin_hak ← 3

    // PIN doğrulama
    DÖNGÜ pin_hak > 0 TEKRAR
        YAZ "Lütfen 4 haneli PIN kodunuzu girin:"
        OKU girilen_pin

        EĞER girilen_pin = PIN_KODU İSE
            ÇIK // PIN doğruysa döngüden çık
        DEĞİLSE
            pin_hak ← pin_hak - 1
            YAZ "Hatalı PIN. Kalan deneme hakkı: ", pin_hak
        SON

    SONDÖNGÜ

    EĞER pin_hak = 0 İSE
        YAZ "Kart bloke oldu. Lütfen banka ile iletişime geçin."
        DUR
    SON

    // Ana işlem döngüsü
    DÖNGÜ TRUE TEKRAR

        YAZ "Çekmek istediğiniz tutarı girin:"
        OKU cekilecek_tutar

        // Tutar kontrolü
        EĞER cekilecek_tutar MOD 20 ≠ 0 İSE
            YAZ "Tutar 20 TL'nin katı olmalıdır."
            DEVAM ET // döngünün başına dön
        SON

        // Günlük limit kontrolü
        EĞER günlük_çekilen + cekilecek_tutar > GÜNLÜK_LİMİT İSE
            YAZ "Günlük limit aşılıyor. Kalan günlük limit: ", GÜNLÜK_LİMİT - günlük_çekilen
            DEVAM ET
        SON

        // Bakiye kontrolü
        EĞER cekilecek_tutar > bakiye İSE
            YAZ "Yetersiz bakiye. Mevcut bakiye: ", bakiye
            DEVAM ET
        SON

        // İşlem başarılı
        bakiye ← bakiye - cekilecek_tutar
        günlük_çekilen ← günlük_çekilen + cekilecek_tutar

        YAZ cekilecek_tutar, " TL başarıyla çekildi."
        YAZ "Kalan bakiye: ", bakiye
        YAZ "Bugün çekilen toplam tutar: ", günlük_çekilen

        // Tekrar işlem seçeneği
        YAZ "Başka bir işlem yapmak istiyor musunuz? (E/H)"
        OKU cevap

        EĞER cevap = "H" VEYA cevap = "h" İSE
            YAZ "İyi günler dileriz."
            DUR
        SON

    SONDÖNGÜ

DUR
