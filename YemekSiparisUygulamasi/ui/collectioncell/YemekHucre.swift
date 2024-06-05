//
//  YemekHucre.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit

protocol YemekHucreProtocol {
    func sepeteEkle(indexPath: IndexPath)
    func favorilereEkle(indexPath: IndexPath, isFavorited: Bool)
}

class YemekHucre: UICollectionViewCell {
    
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var indexPath: IndexPath?
    var yemekHucreProtocol: YemekHucreProtocol?
    var isFavorited: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Başlangıçta buton resmini ayarlayın (eğer gerekliyse)
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        yemekHucreProtocol?.sepeteEkle(indexPath: indexPath!)
    }
    
    @IBAction func favorilereEkleButton(_ sender: Any) {
        let currentImage = favButton.image(for: .normal)
        let newImage = (currentImage == UIImage(systemName: "heart")) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        if newImage == UIImage(systemName: "heart"){
            isFavorited = false
        } else {
            isFavorited = true
        }
        yemekHucreProtocol?.favorilereEkle(indexPath: indexPath!, isFavorited: isFavorited)
        favButton.setImage(newImage, for: .normal)
    }
}
