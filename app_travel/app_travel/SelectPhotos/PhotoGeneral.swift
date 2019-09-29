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

    var arAlbumPhotos: [PHAssetCollection] = [PHAssetCollection]()
    var alert: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.ColoIconViews(type: .White)
        let serialQueue = DispatchQueue(label: "com.queue.serial")
        serialQueue.async {
            self.alert = FunctionAll.share.ShowLoadingWithAlert()
            self.present(self.alert, animated: true, completion: {
                self.setupViews()
            })
        }
//        self.setupViews()
        
    }
    func setupViews(){
        self.fetchAlbum()
        self.setupCustomezeCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupCustomizeNavigation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }

    func fetchAlbum(){
        arAlbumPhotos = FunctionAll.share.fetchCustomAlbumPhotos()
        
    }


    func setupCustomezeCollection(){
        let collect = FunctionAll.share.createCollectionView(colorBR: FunctionAll.share.ColoIconViews(type: .White),
                                                             itemSpace: 0,
                                                             lineSpace: 10,
                                                             isHeader: false
                                                             )
        self.view.addSubview(collect)
        collect.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        collect.delegate = self
        collect.dataSource = self
        collect.register(PhotoGeneralCell.self, forCellWithReuseIdentifier: "cell")
    }

    func setupCustomizeNavigation(){
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
        return self.arAlbumPhotos.count
//        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoGeneralCell
        cell.dataAlbum = self.arAlbumPhotos[indexPath.row]
        cell.alertCell = self.alert
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 40) / 2, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumDetail = self.arAlbumPhotos[indexPath.row]
        let newScr = SelectPhoto()
        newScr.dataAlbum = albumDetail
        self.navigationController?.pushViewController(newScr, animated: true)
    }


}
