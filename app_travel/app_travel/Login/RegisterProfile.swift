//
//  RegisterProfile.swift
//  app_travel
//
//  Created by HaiPhan on 9/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class RegisterProfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: ConstantText.share.txtRegisterEmail)
        setupElementObjectfields()
    }
    
    func setupElementObjectfields(){
        guard let height = self.navigationController?.navigationBar.frame.height else { return }
        let img = FunctionAll.share.createImage(radius: 25, textIMG: "hai")
        self.view.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(height + 20 + 10)
            make.width.height.equalTo(50)
        }
        let lb = FunctionAll.share.createLabel(text: ConstantText.share.txtRegisterUploadaSefie, alignment: .left)
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.centerY.equalTo(img)
            make.height.equalTo(20)
            make.right.equalToSuperview()
        }
        
    }

}
