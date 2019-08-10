//
//  JourniDetailCellDisplay.swift
//  app_travel
//
//  Created by HaiPhan on 8/9/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class JourniDetailCellDisplay: UICollectionViewCell {
    var collect: UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()

    }
    
    func setupView(){
        setupCollectAutolayout()
    }
    
    func setupCollectAutolayout(){
        let layout = UICollectionViewFlowLayout()
        collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collect)
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        collect.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collect.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collect.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        collect.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        collect.delegate = self
        collect.dataSource = self
        collect.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collect.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JourniDetailCellDisplay: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.4239650556, blue: 0.4280975643, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 3 * self.frame.size.height / 4)
    }
    
}
