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
    var sepetYemeklerRXListe = BehaviorSubject(value: [SepetYemek]())
    
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
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        let params: Parameters = ["yemek_adi": yemek_adi,
                                  "yemek_resim_adi": yemek_resim_adi,
                                  "yemek_fiyat": yemek_fiyat,
                                  "yemek_siparis_adet": yemek_siparis_adet,
                                  "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(SepetJSON.self, from: data)
                    print("\(cevap.message!)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetYemeklerYukle(kullanici_adi: String){
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerJSON.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.sepetYemeklerRXListe.onNext(liste)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
