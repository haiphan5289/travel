//
//  my_journis_first_cell.swift
//  app_travel
//
//  Created by HaiPhan on 8/2/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class my_journis_first_cell: UICollectionViewCell {
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set(newValue){
//            var frame = newValue
//            frame.size.width = 200
//            super.frame = frame
//
//        }
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = #colorLiteral(red: 0.2964043173, green: 0.9341040268, blue: 1, alpha: 1)
        setup_view()
    }
    
    func setup_view(){
        label_autolayout()
        bt_autolayout()
    }
    
    func bt_autolayout(){
        let bt = UIButton()
        bt.setImage(UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.addSubview(bt)
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.leftAnchor.constraint(equalTo: self.lb.leftAnchor , constant: 0).isActive = true
        bt.bottomAnchor.constraint(equalTo: self.lb.topAnchor, constant: 0).isActive = true
        bt.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    let lb = UILabel()
    func label_autolayout(){
        lb.text = "New Journi"
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.textAlignment = .center
//        lb.backgroundColor = UIColor.brown
        self.addSubview(lb)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lb.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        lb.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
