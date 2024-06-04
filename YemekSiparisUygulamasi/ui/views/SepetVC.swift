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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
        _ = viewModel.sepetYemeklerRXListe.subscribe(onNext: { sepet in
            self.sepetYemekler = sepet
            DispatchQueue.main.async {
                self.sepetTableView.reloadData()
            }
        })
    }
    
    @IBAction func sepetiOnaylaButton(_ sender: Any) {
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
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.6
        hucre.layer.cornerRadius = 10
        
        return hucre
    }
}
