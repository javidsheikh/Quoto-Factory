//
//  NewQuoto.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import Foundation
import UIKit

class NewQuoto: NSObject {
    
    var quotoImage: UIImage
    var quotoQuote: String
    var quotoAuthor: String
    var quotoCategory: String
    
    init(quotoImage: UIImage, quotoQuote: String, quotoAuthor: String, quotoCategory: String) {
        self.quotoImage = quotoImage
        self.quotoQuote = quotoQuote
        self.quotoAuthor = quotoAuthor
        self.quotoCategory = quotoCategory
    }
}
