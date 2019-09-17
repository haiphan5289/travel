//
//  RecoverPassword.swift
//  app_travel
//
//  Created by HaiPhan on 9/12/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Firebase

class RecoverPassword: UIViewController {

    var heightBottom: Constraint!
    var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: ConstantText.share.txtSignIn)
        setupEmailfields()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardAppear),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func handleKeyBoardAppear(notification: NSNotification){
        if let sizeKeyBoard = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.heightBottom.update(inset: sizeKeyBoard.height + 10)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    func setupEmailfields(){
        let height = self.navigationController!.navigationBar.frame.height
        let lb = FunctionAll.share.createLabel(text: ConstantText.share.txtLBRecoverPwd, alignment: .left)
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(height + 20)
        }
        tfEmail = FunctionAll.share.createTextFieldCustom(text: "", isEmail: true, isPwd: false)
        self.view.addSubview(tfEmail)
        tfEmail.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalTo(lb.snp.bottom).offset(0)
        }
        let btRecover = FunctionAll.share.createSignInBt(radius: 25, text: ConstantText.share.txtRecover)
        btRecover.isEnabled = false
        btRecover.addTarget(self, action: #selector(handleSendPasswordtoEmail), for: .touchUpInside)
        self.view.addSubview(btRecover)
        btRecover.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
            self.heightBottom = make.bottom.equalToSuperview().inset(10).constraint
        }
        
        tfEmail.rx.text.asObservable().subscribe(onNext: {
            if !self.tfEmail.text!.isEmpty {
                btRecover.isEnabled = true
                btRecover.setTitleColor(FunctionAll.share.ColoIconViews(type: .Green), for: .normal)
                print($0!)
            } else {
                btRecover.isEnabled = false
                btRecover.setTitleColor(FunctionAll.share.ColoIconViews(type: .Disable), for: .normal)
                print($0!)
            }
        })
    }
    
    //Xử lý khi nhấn button gưi pass về email
    @objc func handleSendPasswordtoEmail(){
        Auth.auth().sendPasswordReset(withEmail: tfEmail.text!) { (err) in
            if err != nil {
                let alert = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription, title: ConstantText.share.txtAlertFailed)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = FunctionAll.share.ShowAlertBug(text: ConstantText.share.txtContentResetPassword,
                                                           title: ConstantText.share.txtAlertNormal )
                self.tfEmail.text = nil
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
