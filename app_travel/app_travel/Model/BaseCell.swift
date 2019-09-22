//
//  BaseCell.swift
//  app_travel
//
//  Created by HaiPhan on 9/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitial()
    }
    
    func setupInitial(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
