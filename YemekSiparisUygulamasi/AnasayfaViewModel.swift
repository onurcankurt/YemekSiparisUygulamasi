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
}
