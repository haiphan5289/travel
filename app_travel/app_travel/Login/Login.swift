//
//  Login.swift
//  app_travel
//
//  Created by HaiPhan on 8/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

let storage = Storage.storage().reference()
var ref = Database.database().reference()

class Login: UIViewController {
    
    var viewButton: UIView!
    var viewIMG: UIView!
    var viewAlready: UIView!
    var imgLogin: UIImageView!
    var modelText = ConstantText()
    let fbLoginManager: LoginManager = LoginManager()
    var arUsertoCheck: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    func setViews(){
        LoginedSignOut()
        setObjectViewButton()
        setObjectViewIMG()
        setObjectViewAlreadyAccount()
        FetchEmail { (users) -> [String] in
            self.arUsertoCheck = users
            return users
        }
    }
    
    //Hàm quản lý login & signout
    fileprivate func LoginedSignOut() {
        isLogined()
        SignOutUser()
    }
    
    func setObjectViewAlreadyAccount(){
        viewAlready = UIView()
        viewAlready.backgroundColor = .white
        self.view.addSubview(viewAlready)

        viewAlready.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(self.viewButton.snp.bottom)
        }
        setViewAlreadyAutoLayout()
    }
    
    func setViewAlreadyAutoLayout(){
        let viewSeparator = UIView()
        viewSeparator.backgroundColor = .gray
        self.viewAlready.addSubview(viewSeparator)

        viewSeparator.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.viewAlready)
            make.height.equalTo(2)
            make.width.equalTo(self.viewAlready).inset(80)
        }
        
        let textAlready = UILabel()
        textAlready.textAlignment = .center
        textAlready.font = UIFont.systemFont(ofSize: 20)
        textAlready.text = modelText.txtAlready
        self.viewAlready.addSubview(textAlready)

        textAlready.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewAlready).offset(15)
            make.width.equalTo(self.viewAlready).inset(100)
            make.centerX.equalTo(self.viewAlready)
            make.height.equalTo(20)
        }
        
        let signinButton = UIButton(type: .system)
        signinButton.setTitle(modelText.txtSignIn, for: .normal)
        signinButton.setTitleColor(#colorLiteral(red: 0.3753814292, green: 0.7879322652, blue: 0.4544816855, alpha: 1), for: .normal)
        signinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signinButton.titleLabel?.textAlignment = .center
        signinButton.addTarget(self, action: #selector(handleMoveSignIn), for: .touchUpInside)
        self.viewAlready.addSubview(signinButton)

        signinButton.snp.makeConstraints { (make) in
            make.top.equalTo(textAlready.snp.bottom).offset(15)
            make.centerX.equalTo(self.viewAlready.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
    }
    
    //Move to SignIn
    @objc func handleMoveSignIn(){
        self.navigationController?.pushViewController(SignIn(), animated: true)
    }
    
    func setObjectViewButton(){
        viewButton = UIView()
        viewButton.backgroundColor = .white
        self.view.addSubview(viewButton)

        viewButton.snp.makeConstraints { (make) in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
        setViewButtotAutoLayout()
        
    }
    
    func setViewButtotAutoLayout(){
        //        let fbButton = UIButton()
        //        let fbButton = FBLoginButton()
        var fbButton: UIButton!
        fbButton = UIButton()
        //        fbButton.readPermissions = ["public_profile", "email"]
        fbButton.makeColor(text: modelText.txtFBButton,
                           color: FunctionAll.share.ColoIconViews(type: .Blue))
        fbButton.addTarget(self, action: #selector(handleLoginFB), for: .touchUpInside)
        //        fbButton.makeColorFBButton(text: modelText.textFbButton,
        //                                   color: UIColor(red: 61/255, green: 101/255, blue: 161/255, alpha: 1))
        self.viewButton.addSubview(fbButton)
        //        fbButton.delegate = self

        fbButton.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self.viewButton)
            make.width.equalTo(self.viewButton).offset(-80)
            make.height.equalTo(40)
        }
        
        let emailButton = UIButton()
        emailButton.makeColor(text: modelText.txtEmailButton,
                              color: FunctionAll.share.ColoIconViews(type: .Green))
        emailButton.addTarget(self, action: #selector(handleMovetoRegister), for: .touchUpInside)
        self.viewButton.addSubview(emailButton)
        
        emailButton.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(fbButton)
            make.top.equalTo(fbButton.snp.bottom).offset(10)
        }
        
        let textTerm = UILabel()
        textTerm.text = modelText.txtPrivacy
        textTerm.textAlignment = .center
        textTerm.font = UIFont.systemFont(ofSize: 10)
        textTerm.numberOfLines = 2
        self.viewButton.addSubview(textTerm)

        textTerm.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(fbButton)
            make.top.equalTo(emailButton.snp.bottom).offset(10)
        }
    }
    
    @objc func handleMovetoRegister(){
        self.navigationController?.pushViewController(RegisterEmail(), animated: true)
    }
    
    @objc func handleLoginFB(){
        LoginFaceBook()
    }
    
    func LoginFaceBook(){
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("\(String(describing: err))")
                self.fbLoginManager.logOut()
            } else if result!.isCancelled {
                self.fbLoginManager.logOut()
            } else {
                let fbLoginManagerResult: LoginManagerLoginResult = result!
                if fbLoginManagerResult.grantedPermissions != nil {
                    let alert = FunctionAll.share.ShowLoadingWithAlert()
                    self.present(alert, animated: true, completion: nil)
                    //truyền tham chiếu alert
                    self.getDataFacebook(alert: alert, arUsers: self.arUsertoCheck )
                }
            }
        }
    }
    
    func isLogined(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.navigationController?.pushViewController(tab_bar(), animated: true)
            }
        }
        
    }
    
    func SignOutUser(){
        do {
            try Auth.auth().signOut()
        }catch let err as NSError {
            print("\(err)")
        }
        
    }
    
    func setObjectViewIMG(){
        viewIMG = UIView()
        viewIMG.backgroundColor = .white
        self.view.addSubview(viewIMG)

        viewIMG.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.viewButton.snp.top)
        }
        
        setIMGViewIMG()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setIMGViewIMG(){
        UIApplication.shared.statusBarStyle = .lightContent
        
        imgLogin = UIImageView()
        imgLogin.image = UIImage(named: modelText.txtImgLogin)
        imgLogin.contentMode = .scaleToFill
        self.viewIMG.addSubview(imgLogin)
        imgLogin.snp.makeConstraints { (make) in
            make.top.width.centerX.equalTo(self.viewIMG)
            make.height.equalTo(self.viewIMG).multipliedBy(0.75)
        }
        
        let textLogin = UILabel()
        textLogin.text = modelText.txtLogin
        textLogin.font = UIFont.boldSystemFont(ofSize: 14)
        textLogin.textAlignment = .center
        self.viewIMG.addSubview(textLogin)
        textLogin.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(self.viewIMG)
            make.top.equalTo(self.imgLogin.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
    }
    
}

