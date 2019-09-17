//
//  ExtenSion.swift
//  app_travel
//
//  Created by HaiPhan on 8/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

extension UIButton {
    func makeColor(text: String, color: UIColor){
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = color
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
}

extension UIViewController {
    //truyền tham chiếu alert
    func getDataFacebook(alert: UIAlertController, arUsers: [String]){
        //The method gets ìnformation from FB
        //Check AccessToken
        if AccessToken.current != nil {
            //the list parameters đê get data from FB
            let parameters = ["fields": "name, id, email"]
            GraphRequest(graphPath: "me", parameters: parameters).start { (connect, result, err) in
                if err != nil {
                    print("\(String(describing: err))")
                    return
                }
                do {
                    //convert Dic to Data để dẽ hứng dữ liệu
                    let jsonData = try JSONSerialization.data(withJSONObject: result!, options: .prettyPrinted)
                    //parse JsonData with Decode
                    let jsonFB = try JSONDecoder().decode(User.self, from: jsonData)
                    //remove space string
                    //                        print( jsonFB.name!.replacingOccurrences(of: " ", with: ""))
                    let profileUrl = "http://graph.facebook.com/\(jsonFB.id!)/picture?type=large"
                    self.createUserOnFB(email: "facebook.ezy9@gmail.com",
                                        profileUrl: profileUrl,
                                        pwd: jsonFB.id!,
                                        name: jsonFB.name!,
                                        alert: alert,
                                        arUsers: arUsers )
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        else {
            //tắt popup khi đăng nhập FB không thành công
            alert.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func FetchEmail(completion: @escaping ([String]) -> [String]){
        var artemp: [String] = [String]()
        let tableCheck = ref.child("Users")
        tableCheck.observe(.childAdded) { (snap) in
            let temp = snap.value as! NSDictionary
            let emailExist = temp["email"] as! String
            artemp.append(emailExist)
            completion(artemp)
        }
    }
    
    //tạo 1 acc trên FB with email & pwd
    //thêm user vào bảng table
    //navigation qua my_journis_vc
    //thểm 1 biển gồm mảng String, để so sanh email & email tỏng hệ thống
    //hàm tạo User sẽ chỉ làm việc check xem User có trong hệ thông không
    func createUserOnFB(email: String, profileUrl: String, pwd: String, name: String, alert: UIAlertController, arUsers: [String]){
        var isCheckExist: Bool = false
        arUsers.filter { (element) -> Bool in
            if element == email {
                isCheckExist = true
            }
            return true
        }
        CheckEmailExist(isCheckExist, email, pwd, alert, profileUrl, name)
    }
    
    //Nếu user chưa có trong hệ thông thì chạy: CreateUserFaceBook, ngược lại:SignInWithEmailExist
    fileprivate func CheckEmailExist(_ isCheckExist: Bool, _ email: String, _ pwd: String, _ alert: UIAlertController, _ profileUrl: String, _ name: String) {
        if !isCheckExist {
            CreateUserFaceBook(email, pwd, alert, profileUrl, name)
        } else {
            SignInWithEmailExist(email, pwd, alert)
        }
    }

    //tạo User dựa trên email & pwd
    //Nếu có lỗi thì sẽ dismiss alert trước đó và show alert mới
    //Nếu thanh công sẽ dismiss alert và navigation tới my_journis_vc
    fileprivate func CreateUserFaceBook(_ email: String, _ pwd: String, _ alert: UIAlertController, _ profileUrl: String, _ name: String) {
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (result, err) in
            if err != nil {
                print("\(String(describing: err))")
                alert.dismiss(animated: true, completion: nil)
                let alertBug = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription, title: ConstantText.share.txtAlertFailed)
                self.present(alertBug, animated: true, completion: nil)
                return
            }
            alert.dismiss(animated: true) {
                //thêm user vào table user
                let tableUser = ref.child("Users").child(Auth.auth().currentUser!.uid)
                let value: Dictionary<String,Any> = ["uid": Auth.auth().currentUser!.uid,
                                                     "email": email,
                                                     "pwd": pwd,
                                                     "profileUrl": profileUrl,
                                                     "name": name
                ]
                tableUser.setValue(value)
            }
        })
    }
    
    //Login user by: email & pwd
    //Nếu có lỗi thì sẽ dismiss alert trước đó và show alert mới
    //Nếu thanh công sẽ dismiss alert và navigation tới my_journis_vc
    fileprivate func SignInWithEmailExist(_ email: String, _ pwd: String, _ alert: UIAlertController) {
        if AccessToken.current != nil {
            Auth.auth().signIn(withEmail: email, password: pwd) { (resutl, err) in
                if err != nil {
                    print("\(String(describing: err))")
                    alert.dismiss(animated: true, completion: nil)
                    let alertBug = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription, title: ConstantText.share.txtAlertFailed)
                    self.present(alertBug, animated: true, completion: nil)
                    return
                }
                alert.dismiss(animated: true, completion: {
//                    self.navigationController?.pushViewController(my_journis_vc(), animated: true)
                })
            }
        }
    }
    
    //setup Navigation
    func setupNavigation(text: String){
        UIApplication.shared.statusBarStyle = .default
        //remove text back button
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = text
    }
    
}
