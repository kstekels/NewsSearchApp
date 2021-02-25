//
//  SearchViewControllerExtensions.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit
extension SearchViewController {
    
    //MARK: - Setup - func
    func setupView() {
        dataPickerView.dataSource = self
        dataPickerView.delegate = self
        dataPickerView.delegate = self
        selectedTopic = storage.dataList[0]
        manualSearchTextField.placeholder = "Search by keywords here..."
        shortcutSearchButton.layer.cornerRadius = 15
        shortcutSearchButton.backgroundColor = .systemFill
        searchButtonInfoLabel.text = " "
        shortcutSearchButton.isEnabled = false
    }
    
    
    
    //MARK: - Go to article detailed view - func
    func goToDetailedTableview() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "NewsViewControllerID") as? NewsViewController else {
            return
        }
        vc.newsTopic = selectedTopic.trimmingCharacters(in: .whitespacesAndNewlines)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Delete item from picker view - func
    func deleteItem() {
        let deleteShortcutAlert = UIAlertController(title: "Delete", message: "Are you sure you want to Delete \"\(selectedTopic)\"? 🤭 \n(If you want to \"Cancel\", leave the text field empty and just press on \"Delete\" button!", preferredStyle: .alert)
        var deleteTextField: UITextField!
        
        deleteShortcutAlert.addTextField { textField in
            deleteTextField = textField
            deleteTextField.placeholder = "Type \"Delete\" to accept!"
        }
        let addAction = UIAlertAction(title: "Delete -> 🗑?", style: .destructive) { [self] _ in
            
            if deleteTextField.text?.lowercased() == "delete"{
                var itemToDelete = self.storage.dataList.firstIndex(of: selectedTopic)
                if itemToDelete == nil{
                    itemToDelete = saveLastIndex
                }else{
                    self.saveLastIndex = itemToDelete!
                }
                self.storage.dataList.remove(at: (itemToDelete!))
                storage.deleteKeywords()
                
                for item in storage.dataList{
                    let keyword = Keyword()
                    keyword.keyName = item
                    self.storage.saveKeywords(keyword)
                }
                
                self.dataPickerView.reloadAllComponents()
                
            }else{
                deleteTextField.placeholder = "You must enter \"Delete\", to delete selected item!"
                
            }
        }
        
        
        deleteShortcutAlert.addAction(addAction)
        
        
        present(deleteShortcutAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - Add item to picker view - func
    func addShortcutToDataPicker() {
        let addShortcutAlert = UIAlertController(title: "Add  a new shortcut", message: "Enter a new shortcut to access from Picker View!", preferredStyle: .alert)
        var shortcutTextField: UITextField!
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] _ in
            guard let newItem = shortcutTextField.text, !newItem.isEmpty else { return }
            #warning("storage")
            if self.storage.dataList.contains(newItem.lowercased()) {
                print("Element already exist!")
            }else{
                let keyword = Keyword()
                self.storage.dataList.append(newItem.lowercased())
//                self.storage.dataList.sort()
                keyword.keyName = newItem.lowercased()
                self.storage.saveKeywords(keyword)
                self.dataPickerView.reloadAllComponents()
                print("Element is added to list")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addShortcutAlert.addAction(addAction)
        addShortcutAlert.addAction(cancelAction)
        
        addShortcutAlert.addTextField { textField in
            shortcutTextField = textField
            shortcutTextField.placeholder = "Name of topic?"
        }
        
        present(addShortcutAlert, animated: true)
    }
}
