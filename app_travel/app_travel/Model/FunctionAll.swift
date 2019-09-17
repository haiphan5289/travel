//
//  FunctionAll.swift
//  app_travel
//
//  Created by HaiPhan on 9/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import UIKit
import SnapKit

enum ColorIcon {
    case Blue, View, Green, Disable, White
}

class FunctionAll {
    static let share = FunctionAll()
    let modelText = ConstantText()

    
    //tạo 1 alert thông báo với icon Loading
    //Setup & Config activities
    func ShowLoadingWithAlert() -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let activities: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activities.color = FunctionAll.share.ColoIconViews(type: .Blue)
        activities.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activities.startAnimating()
        alert.view.addSubview(activities)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        return alert
    }
    
    //Hiển thị Alert bình thường báo lỗi
    func ShowAlertBug(text: String, title: String) -> UIAlertController{
        let alert: UIAlertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let btCancel: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { (btCancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(btCancel)
        return alert
    }
    
    //tạo 1 danh sach màu cho app
    func ColoIconViews(type: ColorIcon) -> UIColor{
        let cl = type
        switch cl {
        case .Blue:
            return UIColor(red: 61/255, green: 101/255, blue: 161/255, alpha: 1)
        case .Green:
            return UIColor(red: 48/255, green: 192/255, blue: 82/255, alpha: 1)
        case .Disable:
            return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        case .White:
            return UIColor.white
        default:
            return UIColor.orange
        }
    }
    
    //khởi tạo email field
    func createTextFieldCustom(text: String, isEmail: Bool, isPwd: Bool) -> UITextField{
        let txt = UITextField()
        txt.placeholder = text
        txt.backgroundColor = FunctionAll.share.ColoIconViews(type: .Disable)
        //place holder cachc trái
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txt.frame.height))
        txt.leftViewMode = .always
        //show icon clear test
        txt.clearButtonMode = UITextField.ViewMode.whileEditing
        if isEmail {
            txt.keyboardType = .emailAddress
        }
        if isPwd {
            txt.isSecureTextEntry = true
        }
        return txt
    }
    
    //khởi tạo label: forgot password
    func createLabel(text: String, alignment: NSTextAlignment) -> UILabel{
        let lb = UILabel()
        lb.text = text
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textAlignment = alignment
        
        return lb
    }
    //khởi tạo button: button SignIn
    func createSignInBt(radius: CGFloat, text: String) -> UIButton {
        let bt = UIButton(type: .system)
        bt.setTitle(text, for: .normal)
        bt.setTitleColor(FunctionAll.share.ColoIconViews(type: .White), for: .normal)
        bt.backgroundColor = FunctionAll.share.ColoIconViews(type: .Disable)
        bt.layer.cornerRadius = radius
        bt.clipsToBounds = true
        return bt
        
    }
    //hàm kiểm tra text field là email
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    //khởi tạo Image
    func createImage(radius: CGFloat, textIMG: String) -> UIImageView {
        let img: UIImageView = UIImageView()
        img.layer.cornerRadius = radius
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = UIImage(named: textIMG)
        return img
    }
    
    

}
