//
//  AnasayfaViewModel.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var yrepo = YemeklerDaoRepository()
    var yemeklerRXListe = BehaviorSubject(value: [Yemek]())
    
    init() {
        yemeklerRXListe = yrepo.yemeklerRXListe
        yemekleriYukle()
    }
    
    func yemekleriYukle(){
        yrepo.yemekleriYukle()
    }
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        yrepo.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func arananYemekleriYukle(aramaKelimesi: String){
        yrepo.arananYemekleriYukle(aramaKelimesi: aramaKelimesi)
    }
}
