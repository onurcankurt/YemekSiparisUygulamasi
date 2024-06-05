//
//  UrunDetayViewModel.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 5.06.2024.
//

import Foundation

class UrunDetayViewModel {
    var yrepo = YemeklerDaoRepository()
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        yrepo.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
