//
//  SelectPhoto.swift
//  app_travel
//
//  Created by HaiPhan on 9/23/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos
import RxCocoa
import RxSwift

class SelectPhoto: UIViewController {

    var dataAlbum: PHAssetCollection!
    var arPhotos: Array<[arCollection]> = Array<[arCollection]>()
    var collect: UICollectionView!
    var countSelect: Int = 0
    var isDeSelect: Bool = false
    var isSelectAll: Bool = false
    var arPhotosTemp: [arCollection] = [arCollection]()
    var countTotle: Int = 0
    var firstImg: UIImage!
    var lblCount: UILabel!
//    var arTemp = [["A", "B", "C"],
//                  ["D", "E"]
//    ]
    var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.ColoIconViews(type: .White)
        alert = FunctionAll.share.ShowLoadingWithAlert()
        present(alert, animated: true) {
            self.setupViews()
        }
    }
    
    func setupViews(){
        fetchImage()
        setupCustomizeCollect()
        setupCustomizeViewSummary()
    }
    
    func setupCustomizeCollect(){
        //gọi hàm toạ collect
        collect = FunctionAll.share.createCollectionView(colorBR: FunctionAll.share.ColoIconViews(type: .White),
                                                         itemSpace: 2,
                                                         lineSpace: 2,
                                                         isHeader: true
        )
        collect.delegate = self
        collect.dataSource = self
        collect.register(SelectPhotoCell.self, forCellWithReuseIdentifier: "cell")
        //đăng kí lớp header
        collect.register(SelectPhotoHeader.self,
                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                         withReuseIdentifier: "header")
        //tính khoảng cách của cách ở trong
        collect.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        collect.allowsMultipleSelection = true
    }
    
    func setupCustomizeViewSummary(){
        let viewSummary: UIView = UIView()
        viewSummary.backgroundColor = FunctionAll.share.ColoIconViews(type: .White)
        viewSummary.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
        var imgHeader: UIImageView!
        imgHeader = FunctionAll.share.createImage(radius: 5, textIMG: "hai")
        //hiển thị tấm hình cuối cùng
        imgHeader.image = self.arPhotosTemp.first?.img
        viewSummary.addSubview(imgHeader)
        imgHeader.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        let lblTitle: UILabel = FunctionAll.share.createLabel(text: self.dataAlbum.localizedTitle!,
                                                              alignment: .left,
                                                              textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                              isTitle:  true)
        viewSummary.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.left.equalTo(imgHeader.snp.right).offset(10)
            make.right.top.equalToSuperview()
            make.height.equalTo(20)
        }
        lblCount = FunctionAll.share.createLabel(text: String(self.arPhotosTemp.count),
                                                              alignment: .left,
                                                              textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                              isTitle: false)
        viewSummary.addSubview(lblCount)
        lblCount.snp.makeConstraints { (make) in
            make.height.left.right.equalTo(lblTitle)
            make.top.equalTo(lblTitle.snp.bottom)
        }
        let btSelectAll: UIButton = FunctionAll.share.createSignInBt(radius: 10,
                                                                     text: "Select All",
                                                                     isImage: false,
                                                                     textImg: "",
                                                                     colorBR: FunctionAll.share.ColoIconViews(type: .Blue))
        btSelectAll.addTarget(self, action: #selector(handleSelectAll), for: .touchUpInside)
        viewSummary.addSubview(btSelectAll)
        btSelectAll.snp.makeConstraints { (make) in
            make.left.height.equalTo(lblTitle)
            make.top.equalTo(lblCount.snp.bottom)
            make.width.equalTo(100)
        }
        setupCustomizeStackView(viewSummary: viewSummary)
    }
    
    @objc func handleSelectAll(sender: UIButton){
        if isSelectAll {
            SelectAll(isSelected: false)
            isSelectAll = false
            sender.setTitle(ConstantText.share.txtSelectAll, for: .normal)
        } else {
            SelectAll(isSelected: true)
            isSelectAll = true
            sender.setTitle(ConstantText.share.txtDeselectAll, for: .normal)
        }
        
    }
    //tự chọn select all
    fileprivate func SelectAll(isSelected: Bool) {
        //lấy index của từng phần trong mảng
        //lấy section trước
        for section in self.arPhotos.indices {
            //sau đó lấy row
            for row in self.arPhotos[section].indices{
                let index = IndexPath(row: row, section: section)
                let cell = self.collect.cellForItem(at: index) as! SelectPhotoCell
                cell.btCheck.isSelected = isSelected
            }
        }
    }
    
    func setupCustomizeStackView(viewSummary: UIView){
        //tạo 1 stack
        //mode là vetical
        // khoảng cách =
        let stack: UIStackView = UIStackView(arrangedSubviews: [viewSummary, collect])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        self.view.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            //khoảng cách của status bar & navigation bar
            make.top.equalToSuperview().offset(64)
        }
    }
    
    func fetchImage(){
        DispatchQueue.main.async {
            //xử lý bằng cách gét 1 phần từ ra mạc dù nó chỉ có 1 phần tủw
            let elementCollection = FunctionAll.share.fetchAlbumFilterName(fetchOptions: FunctionAll.share.FilterNameAlbum(albumName: self.dataAlbum.localizedTitle!),
                                                                           type: .album).first
            //fetch img và thuộc tính image vaf biến
            self.arPhotosTemp = FunctionAll.share.FetchPhotoFromPHAssetCollection(elementCollection!)
            //sort time của arPhotosTemp
//            arPhotosTemp.sort { $0.createDate < $1.createDate }
            //group các phần tử của biến arCollection vào trong group CreateDate
            let dictionary = Dictionary(grouping: self.arPhotosTemp, by: { (element: arCollection) in
                return element.createDate
            })
            //Convert Dic to Array
            //sort lại array theo điều kiện create date
            self.arPhotos = Array(dictionary.values).sorted { (s1, s2) -> Bool in
                return s1[0].createDate > s2[0].createDate
            }
            self.collect.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigation(text: ConstantText.share.txtSelectPhoto)
    }


}

extension SelectPhoto: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.arTemp[section].count
        return self.arPhotos[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return arTemp.count
        return self.arPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectPhotoCell
        //Hướng protocool khi click button ở bên Cell
        cell.delegate = self
        cell.img.image = self.arPhotos[indexPath.section][indexPath.row].img
        cell.currentSection = indexPath.section
        self.alert.dismiss(animated: true, completion: nil)
//        cell.btCheck.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        return cell
    }
    
//    @objc func handleSelect(){
//        let cell = self.collect.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath(row: 0, section: 0)) as! SelectPhotoCell
//        cell.btCheck.setTitle("hihi", for: .normal)
//        self.collect.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "header",
                                                                     for: indexPath) as! SelectPhotoHeader
        header.lbInfor.text = self.arPhotos[indexPath.section][indexPath.row].createDate

        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 10) / 5, height: (self.view.bounds.width - 10) / 5)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//    }
    
}

extension SelectPhoto: delegateGetDatafromSelectPhotoCell {
    
    func getData(isPlus: Bool, section: Int ) {
        let index = IndexSet(integer: section)
        if isPlus {
            self.countSelect += 1
        } else {
            self.countSelect -= 1
        }
        if self.countSelect == 0 {
            //change text section khi click button ở cell
            self.isDeSelect = false
            let change = self.collect.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader,
                                                        at: IndexPath(row: 0, section: section)) as! SelectPhotoHeader
            change.lbSelect.text = ConstantText.share.txtSelectPhoto

        } else {
//            self.isDeSelect = true
            //update laji text section
            let change = self.collect.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader,
                                                        at: IndexPath(row: 0, section: section)) as! SelectPhotoHeader
            change.lbSelect.text = ConstantText.share.txtDeSelectPhoto
//            self.collect.reloadSections(index)
        }
    }
    
    
}
