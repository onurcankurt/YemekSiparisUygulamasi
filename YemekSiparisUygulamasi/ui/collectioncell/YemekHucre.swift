//
//  YemekHucre.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit

protocol YemekHucreProtocol {
    func sepeteEkle(indexPath: IndexPath)
    func favorilereEkle(indexPath: IndexPath)
}

class YemekHucre: UICollectionViewCell {
    
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var indexPath: IndexPath?
    var yemekHucreProtocol: YemekHucreProtocol?
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        yemekHucreProtocol?.sepeteEkle(indexPath: indexPath!)
    }
    
    @IBAction func favorilereEkleButton(_ sender: Any) {
        yemekHucreProtocol?.favorilereEkle(indexPath: indexPath!)
    }
}
