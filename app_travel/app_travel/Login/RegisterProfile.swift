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
import Firebase


class RegisterProfile: UIViewController {
    
    var btRegister: UIButton!
    var txtEmailTemp: String!
    var txtEmail: String!
    var tfPwd: UITextField!
    var img: UIImageView!
    var tfFirstName: UITextField!
    var tfLastName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        txtEmail = txtEmailTemp
    }
    
    func setupViews(){
        self.setupNavigation(text: ConstantText.share.txtRegisterEmail)
        setupElementObjectfields()
    }
    
    //Setup thuộc tính cho các fiedls
    func setupElementObjectfields(){
        //tạo biển để kiểm tra các field có hợp lệ
        var isCheckPwd: Bool = false
        var isCheckFirstName: Bool = false
        var isCheckLastName: Bool = false
        //lấy khoảng cách của navigation bar
        guard let height = self.navigationController?.navigationBar.frame.height else { return }
        img = FunctionAll.share.createImage(radius: 25, textIMG: "camera")
        self.view.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(height + 20 + 10)
            make.width.height.equalTo(50)
        }
        let lb = FunctionAll.share.createLabel(text: ConstantText.share.txtRegisterUploadaSefie,
                                               alignment: .left,
                                               textColor: FunctionAll.share.ColoIconViews(type: .Black),
                                               isTitle: true)
        self.view.addSubview(lb)
        lb.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.centerY.equalTo(img)
            make.height.equalTo(20)
            make.right.equalToSuperview()
        }
        tfFirstName = FunctionAll.share.createTextFieldCustom(text: ConstantText.share.txtFirstName, isEmail: false, isPwd: false)
        self.view.addSubview(tfFirstName)
        tfFirstName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.top.equalTo(img.snp.bottom).offset(10)
        }
        
        tfLastName = FunctionAll.share.createTextFieldCustom(text: ConstantText.share.txtLastName, isEmail: false, isPwd: false)
        self.view.addSubview(tfLastName)
        tfLastName.snp.makeConstraints { (make) in
            make.top.equalTo(tfFirstName.snp.bottom).offset(10)
            make.left.right.height.equalTo(tfFirstName)
            
        }
    
        tfPwd = FunctionAll.share.createTextFieldCustom(text: ConstantText.share.txtPwd, isEmail: false, isPwd: true)
        self.view.addSubview(tfPwd)
        tfPwd.snp.makeConstraints { (make) in
            make.top.equalTo(tfLastName.snp.bottom).offset(10)
            make.left.right.height.equalTo(tfLastName)
            
        }
        
        
        btRegister = FunctionAll.share.createSignInBt(radius: 20,
                                                      text: ConstantText.share.txtRegisterEmail,
                                                      isImage: false,
                                                      textImg: "",
                                                      colorBR: FunctionAll.share.ColoIconViews(type: .Disable)
        )
//        btRegister.setTitleColor(FunctionAll.share.ColoIconViews(type: .Disable), for: .normal)
        btRegister.addTarget(self, action: #selector(handleRegisterEmail), for: .touchUpInside)
        btRegister.isEnabled = true
        self.view.addSubview(btRegister)
        btRegister.snp.makeConstraints { (make) in
            make.top.equalTo(tfPwd.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        //dùng rx để theo dõi dũ liệu text field có hợp lệ không
        tfFirstName.rx.text.asObservable().subscribe(onNext: {
            if self.tfFirstName.text!.isEmpty {
                isCheckFirstName = false
            } else {
                isCheckFirstName = true
            }
            self.CheckValidbtRegister(isCheckFirstName: isCheckFirstName, isCheckLastName: isCheckLastName, isCheckPwd: isCheckPwd)
            print($0!)
        })
        
        tfLastName.rx.text.asObservable().subscribe(onNext: {
            if self.tfFirstName.text!.isEmpty {
                isCheckLastName = false
            } else {
                isCheckLastName = true
            }
            self.CheckValidbtRegister(isCheckFirstName: isCheckFirstName, isCheckLastName: isCheckLastName, isCheckPwd: isCheckPwd)
            print($0!)
        })
        
        tfPwd.rx.text.asObservable().subscribe(onNext: {
            guard let count = self.tfPwd.text?.count else { return }
            if count >= 6 {
                isCheckPwd = true
            } else {
                isCheckPwd = false
            }
            self.CheckValidbtRegister(isCheckFirstName: isCheckFirstName, isCheckLastName: isCheckLastName, isCheckPwd: isCheckPwd)
            print($0!)
        })
    }
    
    //Upload img lên Firebase
    fileprivate func uploadProfilUsertoFB(imgData: Data, txtpwd: String, firstName: String, lasName: String, alert: UIAlertController ) {
        //tắt alert sau khi tạo User lên authenicate thành công
        alert.dismiss(animated: true) {
            DispatchQueue.main.async {
                let storageFolder = storage.child("imagesProfile:/\(String(describing: self.txtEmail)).jpg")
                _ = storageFolder.putData(imgData, metadata: nil, completion: { (metadata, err) in
                    if err != nil {
                        print("\(err!.localizedDescription)")
                    } else {
                        //lấy url sau khi upload hình lên
                        storageFolder.downloadURL(completion: { (url, err) in
                            if err != nil {
                                print("\(err!.localizedDescription)")
                            } else {
                                guard let currentUser = Auth.auth().currentUser else { return }
                                //gọi hàm add User
                                FunctionAll.share.addUsertoFirebase(id: currentUser.uid,
                                                                    email: self.txtEmail,
                                                                    pwd: txtpwd,
                                                                    profileUrl: url!.absoluteString,
                                                                    firstName: firstName,
                                                                    lastName: lasName)
                            }
                        })
                    }
                }).resume()
            }
        }
       
    }
    
    //Biến đổi dữ liệu để truyền vào hàm upload Profile
    @objc func handleRegisterEmail(){
        let alertSuccess = FunctionAll.share.ShowLoadingWithAlert()
        present(alertSuccess, animated: true, completion: nil)
        guard let txtpwd = self.tfPwd.text, let fname = tfFirstName.text, let lname = tfLastName.text else { return }
        guard let imgData = img.image?.pngData() else { return }
        Auth.auth().createUser(withEmail: txtEmail, password: txtpwd) { (result, err) in
            if err != nil {
                alertSuccess.dismiss(animated: true, completion: nil)
                let alert = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription , title: ConstantText.share.txtAlertNormal)
                self.present(alert, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.uploadProfilUsertoFB(imgData: imgData, txtpwd: txtpwd, firstName: fname, lasName: lname, alert: alertSuccess)
                }
                
            }
        }
    }
    
    private func CheckValidbtRegister(isCheckFirstName: Bool, isCheckLastName: Bool, isCheckPwd: Bool ){
        if isCheckFirstName && isCheckLastName && isCheckPwd {
            btRegister.isEnabled = true
            btRegister.setTitleColor(FunctionAll.share.ColoIconViews(type: .Green), for: .normal)
        } else {
            btRegister.isEnabled =  false
            btRegister.setTitleColor(FunctionAll.share.ColoIconViews(type: .White), for: .normal)
        }
    }

}
