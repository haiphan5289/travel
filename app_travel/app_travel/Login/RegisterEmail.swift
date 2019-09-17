//
//  RegisterEmail.swift
//  app_travel
//
//  Created by HaiPhan on 9/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class RegisterEmail: UIViewController {

    var heightBottom: Constraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews(){
        setupNavigation(text: ConstantText.share.txtRegisterEmail)
        setupElementEmailfields()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleShowKeyBoard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    @objc func handleShowKeyBoard(notification: NSNotification){
        if let sizeKeyBoard = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.heightBottom.update(inset: sizeKeyBoard.height + 10)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func setupElementEmailfields(){
        guard let height = self.navigationController?.navigationBar.frame.height else { return }
        let lb = FunctionAll.share.createLabel(text: ConstantText.share.txtRegisterContent, alignment: .left)
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(height + 20)
        }
        
        let tfEmail = FunctionAll.share.createTextFieldCustom(text: ConstantText.share.txtEmail, isEmail: true, isPwd: false)
        self.view.addSubview(tfEmail)
        tfEmail.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalTo(lb.snp.bottom).offset(0)
        }
        let btNext = FunctionAll.share.createSignInBt(radius: 25, text: ConstantText.share.txtNextbt)
        btNext.isEnabled = false
        btNext.addTarget(self, action: #selector(handleMovetoNext), for: .touchUpInside)
        self.view.addSubview(btNext)
        btNext.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
            self.heightBottom = make.bottom.equalToSuperview().inset(10).constraint
        }
        tfEmail.rx.text.asObservable().subscribe(onNext: {
            let checkEmailValid = FunctionAll.share.isValidEmail(emailStr: $0!)
            if !tfEmail.text!.isEmpty && checkEmailValid {
                btNext.isEnabled = true
                btNext.setTitleColor(FunctionAll.share.ColoIconViews(type: .Green), for: .normal)
            } else {
                btNext.isEnabled = false
                btNext.setTitleColor(FunctionAll.share.ColoIconViews(type: .Disable), for: .normal)
            }
            print($0)
        })

    }
    
    @objc func handleMovetoNext(){
        self.navigationController?.pushViewController(RegisterProfile(), animated: true)
    }


}
