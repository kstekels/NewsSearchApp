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
        self.title = "Search news"
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        dataPickerView.dataSource               = self
        dataPickerView.delegate                 = self
        dataPickerView.delegate                 = self
        selectedTopic = storage.dataList[0]
        manualSearchTextField.placeholder       = "Search news by keywords here..."
        manualSearchTextField.backgroundColor   = .systemFill
        shortcutSearchButton.layer.cornerRadius = 15
        shortcutSearchButton.backgroundColor    = .systemFill
        searchButtonInfoLabel.text              = " "
        shortcutSearchButton.isEnabled          = false

    }
    
    //MARK: - Texfield condition
    func textfieldActionManager() {
        if manualSearchTextField.text == ""{
            manualSearchTextField.placeholder = "Please Enter a text!"
        }else{
            selectedTopic = manualSearchTextField.text!
            goToDetailedTableview()
        }
    }
    
    //MARK: - Info
    func infoButtonAlert(){
        let alert = UIAlertController(title: "Info!👇", message: "\nIn this App you can search news by keywords or phrases.\nYou can use shortcuts or search directly in text field!\n\nTo add a new shortcut, press \"+\"!\n\nTo delete picked shortcut press on trash can!\n", preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true)
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
        let deleteShortcutAlert = UIAlertController(title: "Delete", message: "Are you sure you want Delete \"\(selectedTopic)\"? 🤭 \n(If you want to \"Cancel\", leave the text field empty and just press on \"Delete\" button!", preferredStyle: .alert)
        var deleteTextField: UITextField!
        
        deleteShortcutAlert.addTextField { textField in
            deleteTextField = textField
            deleteTextField.placeholder = "Type \"Delete\" to accept!"
        }
        let addAction = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            
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
                deleteTextField.placeholder = "You must enter \"Delete\", to delete selected shortcut!"
                
            }
        }
        
        deleteShortcutAlert.addAction(addAction)
        present(deleteShortcutAlert, animated: true, completion: nil)
    }
    
    //MARK: - Add item to picker view - func
    func addShortcutToDataPicker() {
        let addShortcutAlert = UIAlertController(title: "Add  a new shortcut", message: "Enter a new shortcut to access to it from Picker View!", preferredStyle: .alert)
        var shortcutTextField: UITextField!
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] _ in
            guard let newItem = shortcutTextField.text, !newItem.isEmpty else { return }
            
            if self.storage.dataList.contains(newItem.lowercased()) {
                print("Shortcut exist!")
            }else{
                let keyword = Keyword()
                self.storage.dataList.append(newItem.lowercased())
                keyword.keyName = newItem.lowercased()
                self.storage.saveKeywords(keyword)
                self.dataPickerView.reloadAllComponents()
                print("Shortcut is saved!")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addShortcutAlert.addAction(addAction)
        addShortcutAlert.addAction(cancelAction)
        
        addShortcutAlert.addTextField { textField in
            shortcutTextField = textField
            shortcutTextField.placeholder = "Shortcut name?"
        }
        
        present(addShortcutAlert, animated: true)
    }
    
    //MARK: - Moving keyboard
    // Will show
    @objc func keyboardWillShow(notification: Notification){
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 10
        }
    }
    // Will hide
    @objc func keyboardWillHide(notification: Notification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 10
        }
    }
    
    // Will hide when user tap on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
