//
//  ExtenSion.swift
//  app_travel
//
//  Created by HaiPhan on 8/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

extension UIButton {
    func makeColor(text: String, color: UIColor){
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 20
        self.backgroundColor = color
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
}
