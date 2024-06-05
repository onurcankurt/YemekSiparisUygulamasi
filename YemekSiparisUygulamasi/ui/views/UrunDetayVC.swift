//
//  UrunDetayVC.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit
import Kingfisher

class UrunDetayVC: UIViewController {
    
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekAdetLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    
    var detayYemek: Yemek?
    var viewModel = UrunDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let y = detayYemek {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with: url)
                }
            }
            yemekAdLabel.text = "\(y.yemek_adi!)"
            yemekFiyatLabel.text = "₺\(y.yemek_fiyat!)"
            yemekAdetLabel.text = "0"
            toplamFiyatLabel.text = "₺0"
            
        }
    }
    
    @IBAction func yemekAzaltButton(_ sender: Any) {
        if var yemekAdet = Int(yemekAdetLabel.text!){
            if yemekAdet == 0 {
                yemekAdetLabel.text = "\(yemekAdet)"
                toplamFiyatLabel.text = "₺0"
            } else {
                yemekAdet -= 1
                yemekAdetLabel.text = "\(yemekAdet)"
                toplamFiyatLabel.text = "₺\(yemekAdet * Int(detayYemek!.yemek_fiyat!)!)"
            }
        }
    }
    
    @IBAction func yemekEkleButton(_ sender: Any) {
        if var yemekAdet = Int(yemekAdetLabel.text!){
            yemekAdet += 1
            yemekAdetLabel.text = "\(yemekAdet)"
            toplamFiyatLabel.text = "₺\(yemekAdet * Int(detayYemek!.yemek_fiyat!)!)"
        }
    }
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        if let yemekAdet = Int(yemekAdetLabel.text!), let y = detayYemek{
            viewModel.sepeteEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(y.yemek_fiyat!)!, yemek_siparis_adet: yemekAdet, kullanici_adi: "kurt_1996")
            
        }
    }
}
