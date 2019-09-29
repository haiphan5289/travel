//
//  SelectPhotoCell.swift
//  app_travel
//
//  Created by HaiPhan on 9/24/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

protocol delegateGetDatafromSelectPhotoCell {
    func getData(isPlus: Bool, section: Int)
}

class SelectPhotoCell: BaseCell {
    var btCheck: UIButton!
    var delegate: delegateGetDatafromSelectPhotoCell?
    var currentSection: Int!
    var img: UIImageView!
    override func setupInitial() {
        super.setupInitial()
        setupViews()
    }
    
    func setupViews(){
        setupCustomizeImage()
    }
    
    func setupCustomizeImage(){
        img = FunctionAll.share.createImage(radius: 0, textIMG: "hai")
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        btCheck = FunctionAll.share.createSignInBt(radius: 10,
                                                       text: "",
                                                       isImage: true,
                                                       textImg: "uncheck",
                                                       colorBR: .clear)
        btCheck.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        self.addSubview(btCheck)
        btCheck.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    @objc func handleSelect(sender: UIButton){
        if btCheck.isSelected {
            btCheck.isSelected = false
            self.delegate?.getData(isPlus: false, section: currentSection)
        } else {
            btCheck.isSelected = true
            self.delegate?.getData(isPlus: true, section: currentSection)
        }
    }
    
}
