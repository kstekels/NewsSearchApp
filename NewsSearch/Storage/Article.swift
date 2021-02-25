//
//  Article.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import RealmSwift
import Foundation
import UIKit

class Article: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var image: Data? = nil
    
    
}

