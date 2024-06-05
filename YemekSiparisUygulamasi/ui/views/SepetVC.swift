//
//  SepetVC.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit

class SepetVC: UIViewController {
    
    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    
    var sepetYemekler = [SepetYemek]()
    var viewModel = SepetViewModel()
    var toplamFiyat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
        _ = viewModel.sepetYemeklerRXListe.subscribe(onNext: { sepet in
            self.sepetYemekler = sepet
            self.updateTotalPrice()
            DispatchQueue.main.async {
                self.sepetTableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        viewModel.sepetYemeklerYukle(kullanici_adi: "kurt_1996")
        sepetTableView.reloadData()
    }
    
    @IBAction func sepetiOnaylaButton(_ sender: Any) {
    }
    
    func updateTotalPrice() {
        print("updated total price")
        toplamFiyat = 0
        for yemek in sepetYemekler {
            toplamFiyat += Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
        }
        toplamFiyatLabel.text = "₺\(toplamFiyat)"
    }
}

extension SepetVC: SepetHucreProtocol {
    func yemekSil(indexPath: IndexPath) {
        let yemek = sepetYemekler[indexPath.row]
        viewModel.sepetYemekSil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: "kurt_1996")
    }
}

extension SepetVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sepetYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sepetYemek = sepetYemekler[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetHucre") as! SepetHucre
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(sepetYemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                hucre.yemekImageView.kf.setImage(with: url)
            }
        }
        hucre.yemekAdLabel.text = sepetYemek.yemek_adi!
        hucre.yemekFiyatLabel.text = "₺ \(sepetYemek.yemek_fiyat!)"
        hucre.yemekAdetLabel.text = sepetYemek.yemek_siparis_adet!
        hucre.toplamFiyatLabel.text = "\(Int(sepetYemek.yemek_fiyat!)! * Int(sepetYemek.yemek_siparis_adet!)!)"
        
        hucre.indexPath = indexPath
        hucre.sepetHucreProtocol = self
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.6
        hucre.layer.cornerRadius = 10
        
        return hucre
    }
}
