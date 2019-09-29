//
//  SelectPhotoHeader.swift
//  app_travel
//
//  Created by HaiPhan on 9/24/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class SelectPhotoHeader: BaseHeader {
    var lbSelect: UILabel!
    var lbInfor: UILabel!
    override func setupInitital() {
        super.setupInitital()
//        self.backgroundColor = 
        setupViews()
    }
    
    func setupViews(){
        setupCustomizeLBSelect()
    }
    
    func setupCustomizeLBSelect(){
        lbSelect = FunctionAll.share.createLabel(text: "Select",
                                                     alignment: .right,
                                                     textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                     isTitle: false)
        self.addSubview(lbSelect)
        lbSelect.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        lbInfor = FunctionAll.share.createLabel(text: "Information",
                                                    alignment: .left,
                                                    textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                                    isTitle: false)
        self.addSubview(lbInfor)
        lbInfor.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(lbSelect.snp.left)
        }
    }
}
