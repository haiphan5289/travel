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
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()

    }
    
    func setViews(){
        setObjectViewButton()
        setObjectViewIMG()
        setObjectViewAlreadyAccount()
    }
    
    func setObjectViewAlreadyAccount(){
        viewAlready = UIView()
        viewAlready.backgroundColor = .white
        self.view.addSubview(viewAlready)
        
        viewAlready.translatesAutoresizingMaskIntoConstraints = false
        viewAlready.topAnchor.constraint(equalTo: self.viewButton.bottomAnchor, constant: 0).isActive = true
        viewAlready.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        viewAlready.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        viewAlready.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        setViewAlreadyAutoLayout()
        
        
    }
    
    func setViewAlreadyAutoLayout(){
        let viewSeparator = UIView()
        viewSeparator.backgroundColor = .gray
        self.viewAlready.addSubview(viewSeparator)
        
        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator.topAnchor.constraint(equalTo: self.viewAlready.topAnchor, constant: 0).isActive = true
        viewSeparator.widthAnchor.constraint(equalTo: self.viewAlready.widthAnchor, constant: -80).isActive = true
        viewSeparator.centerXAnchor.constraint(equalTo: self.viewAlready.centerXAnchor, constant: 0).isActive = true
        viewSeparator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        let textAlready = UILabel()
        textAlready.textAlignment = .center
        textAlready.font = UIFont.systemFont(ofSize: 20)
        textAlready.text = modelText.txtAlready
        self.viewAlready.addSubview(textAlready)
        
        textAlready.translatesAutoresizingMaskIntoConstraints = false
        textAlready.topAnchor.constraint(equalTo: self.viewAlready.topAnchor, constant: 15).isActive = true
        textAlready.widthAnchor.constraint(equalTo: self.viewAlready.widthAnchor, constant: -100).isActive = true
        textAlready.centerXAnchor.constraint(equalTo: self.viewAlready.centerXAnchor, constant: 0).isActive = true
        textAlready.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let signinButton = UIButton(type: .system)
        signinButton.setTitle(modelText.txtSignIn, for: .normal)
        signinButton.setTitleColor(#colorLiteral(red: 0.3753814292, green: 0.7879322652, blue: 0.4544816855, alpha: 1), for: .normal)
        signinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signinButton.titleLabel?.textAlignment = .center
        signinButton.addTarget(self, action: #selector(handleMoveSignIn), for: .touchUpInside)
        self.viewAlready.addSubview(signinButton)
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.topAnchor.constraint(equalTo: textAlready.bottomAnchor, constant: 15).isActive = true
        signinButton.centerXAnchor.constraint(equalTo: self.viewAlready.centerXAnchor, constant: 0).isActive = true
        signinButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        signinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }
    
    //Move to SignIn
    @objc func handleMoveSignIn(){
        self.navigationController?.pushViewController(SignIn(), animated: true)
    }
    
    func setObjectViewButton(){
        viewButton = UIView()
        viewButton.backgroundColor = .white
        self.view.addSubview(viewButton)
        
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        viewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        viewButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        viewButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        viewButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
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
        
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.topAnchor.constraint(equalTo: self.viewButton.topAnchor, constant: 5).isActive = true
        fbButton.widthAnchor.constraint(equalTo: self.viewButton.widthAnchor, constant: -80).isActive = true
        fbButton.centerXAnchor.constraint(equalTo: self.viewButton.centerXAnchor, constant: 0).isActive = true
        fbButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let emailButton = UIButton()
        emailButton.makeColor(text: modelText.txtEmailButton,
                              color: FunctionAll.share.ColoIconViews(type: .Green))
        self.viewButton.addSubview(emailButton)
        
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        emailButton.topAnchor.constraint(equalTo: fbButton.bottomAnchor, constant: 10).isActive = true
        emailButton.centerXAnchor.constraint(equalTo: fbButton.centerXAnchor, constant: 0).isActive = true
        emailButton.widthAnchor.constraint(equalTo: fbButton.widthAnchor, constant: 0).isActive = true
        emailButton.heightAnchor.constraint(equalTo: fbButton.heightAnchor, multiplier: 1).isActive = true
        
        let textTerm = UILabel()
        textTerm.text = modelText.txtPrivacy
        textTerm.textAlignment = .center
        textTerm.font = UIFont.systemFont(ofSize: 10)
        textTerm.numberOfLines = 2
        self.viewButton.addSubview(textTerm)
        
        textTerm.translatesAutoresizingMaskIntoConstraints = false
        textTerm.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 10).isActive = true
        textTerm.centerXAnchor.constraint(equalTo: fbButton.centerXAnchor, constant: 0).isActive = true
        textTerm.widthAnchor.constraint(equalTo: fbButton.widthAnchor, constant: 0).isActive = true
        textTerm.heightAnchor.constraint(equalTo: fbButton.heightAnchor, multiplier: 1).isActive = true
    }
    
    @objc func handleLoginFB(){
        LoginFB()
    }
    
    func LoginFB(){
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("\(String(describing: err))")
                return
            }
            let fbLoginManagerResult: LoginManagerLoginResult = result!
            if fbLoginManagerResult.grantedPermissions != nil {
                let alert = FunctionAll.share.ShowLoadingWithAlert()
                self.present(alert, animated: true, completion: nil)
                //truyền tham chiếu alert
                self.getDataFacebook(alert: alert)
            }
        }
    }

    func setObjectViewIMG(){
        viewIMG = UIView()
        viewIMG.backgroundColor = .white
        self.view.addSubview(viewIMG)
        
        viewIMG.translatesAutoresizingMaskIntoConstraints = false
        viewIMG.bottomAnchor.constraint(equalTo: self.viewButton.topAnchor, constant: 0).isActive = true
        viewIMG.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        viewIMG.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        viewIMG.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        
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
        
        imgLogin.translatesAutoresizingMaskIntoConstraints = false
        imgLogin.topAnchor.constraint(equalTo: self.viewIMG.topAnchor, constant: 0).isActive = true
        imgLogin.widthAnchor.constraint(equalTo: self.viewIMG.widthAnchor, constant: 0).isActive = true
        imgLogin.centerXAnchor.constraint(equalTo: self.viewIMG.centerXAnchor, constant: 0).isActive = true
        imgLogin.heightAnchor.constraint(equalTo: self.viewIMG.heightAnchor, multiplier: 0.75).isActive = true
        
        let textLogin = UILabel()
        textLogin.text = modelText.txtLogin
        textLogin.font = UIFont.boldSystemFont(ofSize: 14)
        textLogin.textAlignment = .center
        self.viewIMG.addSubview(textLogin)
        
        textLogin.translatesAutoresizingMaskIntoConstraints = false
        textLogin.topAnchor.constraint(equalTo: self.imgLogin.bottomAnchor, constant: 8).isActive = true
        textLogin.centerXAnchor.constraint(equalTo: self.viewIMG.centerXAnchor, constant: 0).isActive = true
        textLogin.widthAnchor.constraint(equalTo: self.viewIMG.widthAnchor, constant: 0).isActive = true
        textLogin.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}

//extension Login: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        print("Completed")
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
//    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
//        return true
//    }
//
//
//}
