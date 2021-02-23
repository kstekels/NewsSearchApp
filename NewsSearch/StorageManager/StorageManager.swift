//
//  StorageManager.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveList(_ dataList: ShortcutDataList, itemName: NameOfItem){
        try! realm.write {
            dataList.listOfData.append(dataList)
        }
    }
    
    static func deleteList(_ dataList: ShortcutDataList) {
        try! realm.write{
            realm.delete(dataList)
        }
    }
    
    
    
}
