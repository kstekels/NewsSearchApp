//
//  SearchViewPickerSetup.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import UIKit
extension SearchViewController {
    //MARK: - Update label under picker view
    func pickerSelected() {
        searchButtonInfoLabel.text = "Search for:  \"\(selectedTopic.capitalized)\"? 🤔"
    }
    
    //MARK: - Picker view - func
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storage.dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storage.dataList[row].capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTopic = self.storage.dataList[row]
        if selectedTopic != " "{
            pickerSelected()
        }else{
            searchButtonInfoLabel.text = " "
        }
        
    }
}
