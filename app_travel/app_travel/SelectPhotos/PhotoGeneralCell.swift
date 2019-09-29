//
//  PhotoGeneralCell.swift
//  app_travel
//
//  Created by HaiPhan on 9/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos

//let imageCache = NSCache<AnyObject, AnyObject>()
//var isData: Bool = false
//var arDic: [AnyObject] = [AnyObject]()

class PhotoGeneralCell: BaseCell {
    var lbCountPhotos: UILabel!
    var lblTitlePhotos: UILabel!
    var imgPhotos: UIImageView!
    var photo: UIImage!
    var images: [UIImage] = [UIImage]()
    var alertCell: UIAlertController!
    var dataAlbum: PHAssetCollection?{
        didSet {
            guard let album = dataAlbum else { return }
            self.lbCountPhotos.text = String(album.estimatedAssetCount)
            self.lblTitlePhotos.text = album.localizedTitle
            DispatchQueue.main.async {
                self.FetchPhotoFromPHAssetCollection(album)
//                FunctionAll.share.FetchPhotoFromPHAssetCollection(album)
                DispatchQueue.main.async {
                    self.imgPhotos.image = self.images.last
                    self.alertCell.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    override func setupInitial() {
        super.setupInitial()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setupViews()
    }

    func setupViews(){
        setupCusstomizelbPhotos()
    }
    
    fileprivate func FetchPhotoFromPHAssetCollection(_ elementCollection: PHAssetCollection) {
        var photoAssets = PHFetchResult<AnyObject>()
        //fetch theo điều kiện
//        let photosOptions = PHFetchOptions()
//        photosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//        photosOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
        
        photoAssets = PHAsset.fetchAssets(in: elementCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        photoAssets.enumerateObjects{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            if object is PHAsset{
                let asset = object as! PHAsset
                //                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                DispatchQueue.main.async {
                    imageManager.requestImage(for: asset,
                                              targetSize: imageSize,
                                              contentMode: .aspectFill,
                                              options: options,
                                              resultHandler: {
                                                (image, info) -> Void in
                                                    // self.photo = image!
                                                    /* The image is now available to us */
                                                    self.addImgToArray(uploadImage: image!)
                                                }
                    )}
                }
            }
    }
    
    func addImgToArray(uploadImage:UIImage){
        self.images.append(uploadImage)
    }
    
    
    private func setupCusstomizelbPhotos(){
        lbCountPhotos = FunctionAll.share.createLabel(text: "222",
                                                      alignment: .left,
                                                      textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                      isTitle: false)
        self.addSubview(lbCountPhotos)
        
        lbCountPhotos.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)
        }
        lblTitlePhotos = FunctionAll.share.createLabel(text: "Selfie",
                                                       alignment: .left,
                                                       textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                       isTitle: true)
        self.addSubview(lblTitlePhotos)
        lblTitlePhotos.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(lbCountPhotos.snp.top).inset(10)
            make.height.equalTo(lbCountPhotos)
        }
        imgPhotos = UIImageView()
        imgPhotos.image = UIImage(named: "hai")
        imgPhotos.contentMode = .scaleToFill
        self.addSubview(imgPhotos)
        
        imgPhotos.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.bottom.equalTo(lblTitlePhotos.snp.top)
            
        }
    }

}
