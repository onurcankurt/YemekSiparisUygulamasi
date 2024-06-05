//
//  SepetViewModel.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import Foundation
import RxSwift

class SepetViewModel {
    var yrepo = YemeklerDaoRepository()
    var sepetYemeklerRXListe = BehaviorSubject(value: [SepetYemek]())
    
    init() {
        sepetYemeklerRXListe = yrepo.sepetYemeklerRXListe
        sepetYemeklerYukle(kullanici_adi: "kurt_1996")
        
    }
    
    func sepetYemeklerYukle(kullanici_adi: String){
        yrepo.sepetYemeklerYukle(kullanici_adi: kullanici_adi)
    }
    
    func sepetYemekSil(sepet_yemek_id: Int, kullanici_adi: String){
        yrepo.sepetYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}
