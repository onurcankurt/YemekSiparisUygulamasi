//
//  ViewController.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit
import Kingfisher

class Anasayfa: UIViewController {
    
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    var yemeklerListesi = [Yemek]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        _ = viewModel.yemeklerRXListe.subscribe(onNext: { yemekListe in
            self.yemeklerListesi = yemekListe
            DispatchQueue.main.async {
                self.yemeklerCollectionView.reloadData()
            }
        })
        
        
        let design = UICollectionViewFlowLayout()
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.50)
        yemeklerCollectionView.collectionViewLayout = design
    }
}

extension Anasayfa: YemekHucreProtocol {
    func sepeteEkle(indexPath: IndexPath) {
        print("sepete eklendi")
    }
    
    func favorilereEkle(indexPath: IndexPath) {
        print("dfdf")
    }
    
    
}

extension Anasayfa: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemekHucre
        
        //hucre.yemekImageView.image = UIImage(named: yemek.yemek_resim_adi!)
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            hucre.yemekImageView.kf.setImage(with: url)
        }
        
        hucre.yemekAdLabel.text = "\(yemek.yemek_adi!)"
        hucre.yemekFiyatLabel.text = "₺ \(yemek.yemek_fiyat!)"
        
        hucre.yemekHucreProtocol = self
        hucre.indexPath = indexPath
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10
        
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toUrunDetayVC", sender: yemek)
    }
}

