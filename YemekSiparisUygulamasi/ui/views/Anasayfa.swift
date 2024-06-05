//
//  ViewController.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit
import Kingfisher

class Anasayfa: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    var yemeklerListesi = [Yemek]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
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

extension Anasayfa: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            viewModel.arananYemekleriYukle(aramaKelimesi: searchText)
        } else {
            viewModel.yemekleriYukle()
        }
    }
}

extension Anasayfa: YemekHucreProtocol {
    func favorilereEkle(indexPath: IndexPath, isFavorited: Bool) {
        if isFavorited == true{
            print("\(yemeklerListesi[indexPath.row].yemek_adi!) favorilere eklendi.")
        } else {
            print("\(yemeklerListesi[indexPath.row].yemek_adi!) favorilerden çıkarıldı.")
        }
    }
    
    func sepeteEkle(indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        print("\(yemek.yemek_adi!) sepete eklendi.")
        viewModel.sepeteEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: 1, kullanici_adi: "kurt_1996")
    }
}

extension Anasayfa: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemekHucre
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                hucre.yemekImageView.kf.setImage(with: url)
            }
        }
        
        hucre.yemekAdLabel.text = "\(yemek.yemek_adi!)"
        hucre.yemekFiyatLabel.text = "₺ \(yemek.yemek_fiyat!)"
        
        hucre.yemekHucreProtocol = self
        hucre.indexPath = indexPath
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.6
        hucre.layer.cornerRadius = 10
        
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toUrunDetayVC", sender: yemek)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUrunDetayVC" {
            if let senderYemek = sender as? Yemek{
                let destinationVC = segue.destination as? UrunDetayVC
                destinationVC?.detayYemek = senderYemek
            }
        }
    }
}

