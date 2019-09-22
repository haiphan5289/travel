//
//  PhotoGeneral.swift
//  app_travel
//
//  Created by HaiPhan on 9/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import Photos
import RxCocoa
import RxSwift

class PhotoGeneral: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.ColoIconViews(type: .White)
        setupViews()
    }
    
    func setupViews(){
        setupCustomizeNavigation()
        setupCustomezeCollection()
    }
    
    private func setupCustomezeCollection(){
        let collect = FunctionAll.share.createCollectionView(colorBR: FunctionAll.share.ColoIconViews(type: .White))
        self.view.addSubview(collect)
        collect.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        collect.delegate = self
        collect.dataSource = self
        collect.register(PhotoGeneralCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupCustomizeNavigation(){
        self.createNavigationViewInTabBar(statusBar: .default, titlerLarge: false, title: ConstantText.share.txtPhotoGeneral)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(handleBackView))
        let btRight = FunctionAll.share.createSignInBt(radius: 10,
                                                       text: ConstantText.share.txtDone,
                                                       isImage: false,
                                                       textImg: "",
                                                       colorBR: FunctionAll.share.ColoIconViews(type: .Disable))
        btRight.frame.size = CGSize(width: 70, height: 20)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btRight)
    }
    
    @objc func handleBackView(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension PhotoGeneral: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoGeneralCell
 
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 40) / 2, height: 100)
    }
    
    
}
