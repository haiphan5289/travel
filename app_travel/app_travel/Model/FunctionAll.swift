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
    case Blue, View, Green
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
    func ShowAlertBug(text: String) -> UIAlertController{
        let alert: UIAlertController = UIAlertController(title: modelText.txtAlertTitle, message: text, preferredStyle: .alert)
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
        default:
            return UIColor.orange
        }
    }
}
