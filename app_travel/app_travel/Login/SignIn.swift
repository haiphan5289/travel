//
//  SignIn.swift
//  app_travel
//
//  Created by HaiPhan on 9/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import RxCocoa
import RxSwift

class SignIn: UIViewController {
    
    let modeText = ConstantText()
    var heightBottom: Constraint!
    var txtPwd: UITextField!
    var txtEmail: UITextField!
    var btSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: modeText.txtSignIn)
        setupElementViews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKeyBoard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKeyBoard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleShowKeyBoard(notification: NSNotification){
        if let sizeKeyBoard = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(sizeKeyBoard.height)
            self.heightBottom.update(inset: sizeKeyBoard.height + 10)
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleHideKeyBoard(notification: NSNotification){
        self.heightBottom.update(inset: 10)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func setupElementViews(){
//        let bag = DisposeBag()
        var isCheckEmail: Bool = false
        var isCheckPwd: Bool = false
        let height = self.navigationController?.navigationBar.frame.height
        txtEmail = FunctionAll.share.createTextFieldCustom(text: modeText.txtEmail, isEmail: true, isPwd: false)
        self.view.addSubview(txtEmail)
        
        txtEmail.snp.makeConstraints { (make) in
            CalculateAutolayout(make, contrainsItem: self.view.snp.top,
                                topconstant: height! + 20, heightConstant: 50, leftConstant: 10, rightConstant: 10)
        }
        
        txtPwd = FunctionAll.share.createTextFieldCustom(text: modeText.txtPwd, isEmail: false, isPwd: true)
        self.view.addSubview(txtPwd)
        
        txtPwd.snp.makeConstraints { (make) in
            CalculateAutolayout(make, contrainsItem: txtEmail.snp.bottom,
                                topconstant: 10, heightConstant: 50, leftConstant: 10, rightConstant: 10)
        }
        
        let lbForgot = FunctionAll.share.createLabel(text: modeText.txtForgotPwd, alignment: .center)
        lbForgot.isUserInteractionEnabled = true
        lbForgot.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMoveToForgot)))
        self.view.addSubview(lbForgot)
        lbForgot.snp.makeConstraints { (make) in
            CalculateAutolayout(make, contrainsItem: txtPwd.snp.bottom,
                                topconstant: 0, heightConstant: 50, leftConstant: 10, rightConstant: 10)
            
        }
        btSignIn = FunctionAll.share.createSignInBt(radius: 25, text: ConstantText.share.txtSignIn)
        btSignIn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        self.view.addSubview(btSignIn)
        btSignIn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
            self.heightBottom = make.bottom.equalToSuperview().inset(10).constraint
        }
        
        txtEmail.rx.text.asObservable().subscribe(onNext: {
            if !self.txtEmail.text!.isEmpty{
                isCheckEmail = true
                if isCheckPwd && isCheckEmail {
                    self.btSignIn.setTitleColor(FunctionAll.share.ColoIconViews(type: .Green), for: .normal)
                    self.btSignIn.isEnabled = true
                    return
                }
                print($0!)
            } else {
                isCheckEmail = false
                self.btSignIn.setTitleColor(FunctionAll.share.ColoIconViews(type: .White), for: .normal)
                self.btSignIn.isEnabled = false
            }
        })
        txtPwd.rx.text.asObservable().subscribe(onNext: {
            if !self.txtPwd.text!.isEmpty{
                isCheckPwd = true
                if isCheckPwd && isCheckEmail {
                    self.btSignIn.setTitleColor(FunctionAll.share.ColoIconViews(type: .Green), for: .normal)
                    self.btSignIn.isEnabled = true
                    return
                }
                print($0!)
            } else {
                isCheckPwd = false
                self.btSignIn.setTitleColor(FunctionAll.share.ColoIconViews(type: .White), for: .normal)
                self.btSignIn.isEnabled = false
            }
        })
        
    }
    
    @objc func handleSignIn(){
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPwd.text!) { (result, err) in
            if err != nil {
                let alertBug = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription,
                                                              title: ConstantText.share.txtAlertFailed)
                self.present(alertBug, animated: true, completion: nil)
                return
            }
        }
    }
    
    fileprivate func CalculateAutolayout(_ make: ConstraintMaker, contrainsItem: ConstraintItem, topconstant: CGFloat,
                                         heightConstant: CGFloat, leftConstant: CGFloat, rightConstant: CGFloat) {
        make.top.equalTo(contrainsItem).offset(topconstant)
        make.height.equalTo(heightConstant)
        make.left.equalToSuperview().offset(leftConstant)
        make.right.equalToSuperview().inset(rightConstant)
        
    }
    
    @objc func handleMoveToForgot(){
        self.navigationController?.pushViewController(RecoverPassword(), animated: true)
    }
    
}

