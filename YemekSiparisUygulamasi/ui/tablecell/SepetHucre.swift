//
//  SepetHucre.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit

protocol SepetHucreProtocol {
    func yemekSil(indexPath: IndexPath)
}

class SepetHucre: UITableViewCell {
    
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekAdetLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    
    var indexPath: IndexPath?
    var sepetHucreProtocol: SepetHucreProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yemekSilButton(_ sender: Any) {
        sepetHucreProtocol?.yemekSil(indexPath: indexPath!)
    }
}
