//
//  ViewController.swift
//  YemekSiparisUygulamasi
//
//  Created by onur on 4.06.2024.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
    }
}

extension Anasayfa: YemekHucreProtocol {
    func sepeteEkle(indexPath: IndexPath) {
        <#code#>
    }
    
    func favorilereEkle(indexPath: IndexPath) {
        <#code#>
    }
    
    
}

extension Anasayfa: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

