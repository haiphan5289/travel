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
    func getDataFacebook(alert: UIAlertController){
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
//                    FunctionAll.share.createUserOnFB(email: jsonFB.email!,
//                                                     profileUrl: profileUrl,
//                                                     pwd: jsonFB.id!,
//                                                     alert: alert)
                    self.createUserOnFB(email: "22222222@gmail.com",
                                        profileUrl: profileUrl,
                                        pwd: jsonFB.id!,
                                        name: jsonFB.name!,
                                        alert: alert)
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
    //tạo 1 acc trên FB with email & pwd
    //thêm user vào bảng table
    //navigation qua my_journis_vc
    func createUserOnFB(email: String, profileUrl: String, pwd: String, name: String, alert: UIAlertController){
                Auth.auth().createUser(withEmail: email, password: pwd, completion: { (result, err) in
                    if err != nil {
                        print("\(String(describing: err))")
                        alert.dismiss(animated: true, completion: nil)
                        let alertBug = FunctionAll.share.ShowAlertBug(text: err!.localizedDescription)
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
                        
                        self.navigationController?.pushViewController(my_journis_vc(), animated: true)
                    }
                })
    }
    
}
