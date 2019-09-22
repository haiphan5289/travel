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
import SnapKit
import RxCocoa
import RxSwift
import Firebase


class journi_detail: UIViewController {

    var array_img: [UIImage] = [UIImage]()
    var isCheck_move_from_create: Bool = false
    var collect: UICollectionView!
    var isOpenCreateJourni: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setup_view()
    }
    
    func setup_view(){
        removeViewControllers()
        collect_autolayout()
        setupViewBackGround()
        setupNavigation()
        setupViewAction()
        uploadDatatoFirebase()
    }

    func uploadDatatoFirebase(){
        guard let currentUser = Auth.auth().currentUser else { return }
        DispatchQueue.main.async {
            FunctionAll.share.uploadDatatoFireBaseonJourniDetailtableHome(id: currentUser.uid,
                                                                          title: "All Photos",
                                                                          location: "Viet Name",
                                                                          moment: 1,
                                                                          block: 1)
        }
    }
    let viewAction = UIView()
    func setupViewAction(){
        viewAction.backgroundColor = UIColor.white
        self.view.addSubview(viewAction)

        viewAction.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }

//        setupObjectViewAction()
        let buttonGallery = UIButton()
        buttonGallery.setImage(UIImage(named: "gallery"), for: .normal)
        buttonGallery.addTarget(self, action: #selector(HandleShowIMG), for: .touchUpInside)
        viewAction.addSubview(buttonGallery)

        buttonGallery.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.right.equalTo(viewAction).inset(8)
            make.bottom.equalTo(viewAction)
        }

        let txtComment = UITextField()
        txtComment.attributedPlaceholder = NSAttributedString(string: "Aa...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        txtComment.layer.borderColor = UIColor.gray.cgColor
        txtComment.layer.borderWidth = 1
        txtComment.layer.cornerRadius = 20
        txtPaddingVw(txt: txtComment)
        viewAction.addSubview(txtComment)

        txtComment.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(self.viewAction)
            make.right.equalTo(buttonGallery.snp.left).offset(8)
            make.height.equalTo(40)
        }
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
        collect.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()

        }
//        collect.backgroundColor = .red
        collect.delegate = self
        collect.dataSource = self
        collect.register(JourniDetailCell.self, forCellWithReuseIdentifier: "cell")
        collect.register(JourniDetailCellDisplay.self, forCellWithReuseIdentifier: "cellDisplay")
        collect.backgroundColor = UIColor.red
        collect.isPagingEnabled = true
        collect.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }

    var viewNavigation: UIView!
    var viewBackGroundNavigation: UIView!
    func setupNavigation(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        if viewNavigation != nil {
            viewNavigation.isHidden = false
            return
        }
        SettingNavigation()
    }

    func SettingNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.hidesBackButton = true
        viewNavigation = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 44))
        //        self.navigationController?.navigationBar.isTranslucent = true


        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "left_arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        viewNavigation.addSubview(backButton)

        let photoButton = FunctionAll.share.createSignInBt(radius: 0,
                                                           text: "",
                                                           isImage: true,
                                                           textImg: "photo",
                                                           colorBR: FunctionAll.share.ColoIconViews(type: .Blue))
        photoButton.setImage(UIImage(named: "photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        photoButton.frame = CGRect(x: 44, y: 0, width: 44, height: 44)
        photoButton.tintColor = UIColor.white
        viewNavigation.addSubview(photoButton)

        let printButton = FunctionAll.share.createSignInBt(radius: 25,
                                                           text: "Print",
                                                           isImage: false,
                                                           textImg: "",
                                                           colorBR: FunctionAll.share.ColoIconViews(type: .Blue))
        printButton.frame = CGRect(x: self.view.frame.size.width - 84 , y: 5, width: 64, height: 34)
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
        self.navigationController?.pushViewController(tab_bar(), animated: true)
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
            if isOpenCreateJourni {
                cell.imgCover.image = array_img.first
            } else {
                cell.imgCover.image = UIImage(named: "hai")
            }

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
