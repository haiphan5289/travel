//
//  my_journis_cell.swift
//  app_travel
//
//  Created by HaiPhan on 8/1/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class my_journis_cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
