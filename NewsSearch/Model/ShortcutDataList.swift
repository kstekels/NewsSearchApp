//
//  ShortcutDataList.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import Foundation
import RealmSwift

class ShortcutDataList: Object {

    @objc dynamic var listOfData: [String] = []
    
}

class NameOfItem: Object {
    
    @objc dynamic var nameOfShortcut = ""
    
}
