//
//  YemeklerDaoRepository.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import Foundation
import RxSwift
import Alamofire

class YemeklerDaoRepository {
    
    var yemeklerRXListe = BehaviorSubject(value: [Yemek]())
    
    func yemekleriYukle(){
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(YemeklerJSON.self, from: data)
                    if let liste = cevap.yemekler {
                        self.yemeklerRXListe.onNext(liste)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
