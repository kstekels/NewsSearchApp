//
//  StorageManager.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import RealmSwift

class StorageManager {
    let realm = try! Realm()
    
    var dataList: [String] = [" "]
    var keyNameUserInput = String()
    
    func deleteKeywords() {
        realm.beginWrite()
        realm.delete(realm.objects(Keyword.self))
        try! realm.commitWrite()
    }
    
    func loadKeywords() {
        let keys = realm.objects(Keyword.self)
        for key in keys {
            let shortcut = key.keyName
            print(shortcut)
            if !dataList.contains(shortcut){
                dataList.append(shortcut)
            }
            dataList.sort()
            print(dataList)
        }
    }
    
    func saveKeywords(_ key: Keyword) {
        if !dataList.contains(keyNameUserInput){
            print("Saving... -> \(keyNameUserInput)")
            realm.beginWrite()
            realm.add(key)
            try! realm.commitWrite()
        }
    }
    
}
