//
//  User.swift
//  app_travel
//
//  Created by HaiPhan on 9/10/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    var id: String?
    var name: String?
    var email: String?
}

struct arCollection {
    var img: UIImage!
    var createDate: String!
}
