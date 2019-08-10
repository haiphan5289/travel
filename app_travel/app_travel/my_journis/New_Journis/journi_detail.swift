//
//  Juorni_detail.swift
//  app_travel
//
//  Created by HaiPhan on 8/3/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import GoogleMaps
import QBImagePickerController


class journi_detail: UIViewController {

    var array_img: [UIImage] = [UIImage]()
    var isCheck_move_from_create: Bool = false
//    var img_cover: UIImageView!
    var collect: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //remove phần từ viewcontroller = navigation
        if isCheck_move_from_create {
            var array_vc = self.navigationController?.viewControllers
            array_vc?.remove(at: 1)
            self.navigationController?.viewControllers = array_vc!
            isCheck_move_from_create = false
        }
        
        let img = UIImageView(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
        img.image = array_img.first
        self.view.addSubview(img)
        setup_view()
    }
    
    func setup_view(){
//        img_cover_autolayout()
        removeViewControllers()
        collect_autolayout()
        setupViewBackGround()
        setupNavigation()
        setupViewAction()
        
    }
    let viewAction = UIView()
    func setupViewAction(){
        viewAction.backgroundColor = UIColor.white
        self.view.addSubview(viewAction)
        
        viewAction.translatesAutoresizingMaskIntoConstraints = false
        viewAction.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        viewAction.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        viewAction.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        viewAction.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        setupObjectViewAction()
        let buttonGallery = UIButton()
        buttonGallery.setImage(UIImage(named: "gallery"), for: .normal)
        buttonGallery.addTarget(self, action: #selector(HandleShowIMG), for: .touchUpInside)
        viewAction.addSubview(buttonGallery)
        
        buttonGallery.translatesAutoresizingMaskIntoConstraints = false
        buttonGallery.rightAnchor.constraint(equalTo: viewAction.rightAnchor, constant: -8).isActive = true
        buttonGallery.bottomAnchor.constraint(equalTo: viewAction.bottomAnchor, constant: 0).isActive = true
        buttonGallery.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonGallery.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let txtComment = UITextField()
        txtComment.attributedPlaceholder = NSAttributedString(string: "Aa...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        txtComment.layer.borderColor = UIColor.gray.cgColor
        txtComment.layer.borderWidth = 1
        txtComment.layer.cornerRadius = 20
        txtPaddingVw(txt: txtComment)
        viewAction.addSubview(txtComment)
        
        txtComment.translatesAutoresizingMaskIntoConstraints = false
        txtComment.rightAnchor.constraint(equalTo: buttonGallery.leftAnchor, constant: 8).isActive = true
        txtComment.centerYAnchor.constraint(equalTo: viewAction.centerYAnchor, constant: 0).isActive = true
        txtComment.leftAnchor.constraint(equalTo: self.viewAction.leftAnchor, constant: 0).isActive = true
        txtComment.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func HandleShowIMG(){
        let img: QBImagePickerController = QBImagePickerController()
        img.delegate = self
        img.allowsMultipleSelection = true
        img.showsNumberOfSelectedAssets = true
        present(img, animated: true, completion: nil)
        
    }
    
    func txtPaddingVw(txt:UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 5))
        txt.leftViewMode = .always
        txt.leftView = paddingView
    }
    
    
    func collect_autolayout(){
        let layout = UICollectionViewFlowLayout()
        collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collect)
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        collect.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        collect.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        collect.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        collect.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        collect.delegate = self
        collect.dataSource = self
        collect.register(JourniDetailCell.self, forCellWithReuseIdentifier: "cell")
        collect.register(JourniDetailCellDisplay.self, forCellWithReuseIdentifier: "cellDisplay")
        collect.backgroundColor = UIColor.white
        collect.isPagingEnabled = true
    }
    
    var viewNavigation: UIView!
    var viewBackGroundNavigation: UIView!
    func setupNavigation(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isHidden = true
        if viewNavigation != nil {
            viewNavigation.isHidden = false
            return
        }
        SettingNavigation()
    }
    
    func SettingNavigation(){
        viewNavigation = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 44))
        //        self.navigationController?.navigationBar.isTranslucent = true
        
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "left_arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        viewNavigation.addSubview(backButton)
        
        let photoButton = UIButton(type: .custom)
        photoButton.setImage(UIImage(named: "photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        photoButton.frame = CGRect(x: 44, y: 0, width: 44, height: 44)
        photoButton.tintColor = UIColor.white
        viewNavigation.addSubview(photoButton)
        
        let printButton = UIButton(type: .system)
        printButton.setTitle("Print", for: .normal)
        printButton.frame = CGRect(x: self.view.frame.size.width - 84 , y: 5, width: 64, height: 34)
        printButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        printButton.setTitleColor(UIColor.white, for: .normal)
        printButton.layer.cornerRadius = printButton.frame.size.height / 2
        viewNavigation.addSubview(printButton)
        
        self.view.addSubview(viewNavigation)
    }
    
    func setupViewBackGround(){
        viewBackGroundNavigation = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        viewBackGroundNavigation.backgroundColor = UIColor.red
        viewBackGroundNavigation.alpha = 0
        self.view.addSubview(viewBackGroundNavigation)
    }
    
    @objc func handleBack(){
        _ = navigationController?.popViewController(animated: true)
    }

    
    func removeViewControllers(){
        if isCheck_move_from_create {
            var array_vc = self.navigationController?.viewControllers
            array_vc?.remove(at: 1)
            self.navigationController?.viewControllers = array_vc!
            isCheck_move_from_create = false
        }
    }
    

}
extension journi_detail: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JourniDetailCell

            return cell
        }
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "cellDisplay", for: indexPath) as! JourniDetailCellDisplay
  
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collect.contentOffset
        visibleRect.size = collect.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = collect.indexPathForItem(at: visiblePoint) else { return }
        
        if indexPath.row == 0 {
            viewBackGroundNavigation.alpha = 1
            UIView.animate(withDuration: 0.5) {
                self.viewBackGroundNavigation.alpha = 0
            }
        }
        else if indexPath.row == 1 {
            viewBackGroundNavigation.alpha = 0
            UIView.animate(withDuration: 0.5) {
                UIApplication.shared.statusBarStyle = .lightContent
                self.viewBackGroundNavigation.alpha = 1
            }
        }
    }
    
    
}
extension journi_detail: QBImagePickerControllerDelegate{
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        var arrayImg: [UIImage] = [UIImage]()
        for i in assets {
            let img = self.getAssetThumbnail(asset: i as! PHAsset)
            arrayImg.append(img)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
