//
//  ViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var topics = ["bitcoin", "apple", "tesla", "spacex", "bmw", "volvo", "audi", "amazon", "telegram", "facebook", "whatsapp", "windows", "android "]
    
    var selectedTopic = ""
    
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var manualSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPickerView.dataSource = self
        dataPickerView.delegate = self
        dataPickerView.delegate = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        manualSearchTextField.text = nil
    }
    
    
    @IBAction func manualSearchButtonPressed(_ sender: Any) {
        if manualSearchTextField.text == ""{
            manualSearchTextField.placeholder = "Please Enter a text!"
        }else{
            selectedTopic = manualSearchTextField.text!
            goToDetailedTableview()
        }
    }
    
    
    @IBAction func NewsShortcutButtonPressed(_ sender: Any) {
        goToDetailedTableview()
    }
    
    @IBAction func navigationBarDeleteButtonPressed(_ sender: Any) {
        deleteItem()
    }
    
    @IBAction func navigationBarAddButtonIsPressed(_ sender: Any) {
        addShortcutToDataPicker()
    }
    
    func goToDetailedTableview() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "NewsViewControllerID") as? NewsViewController else {
            return
        }

        
        vc.newsTopic = selectedTopic.trimmingCharacters(in: .whitespacesAndNewlines)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteItem() {
                
        let deleteShortcutAlert = UIAlertController(title: "Delete", message: "Are you sure you want to Delete this shortcut? 💁‍♂️ \n(If you want to \"Cancel\", just press on \"Delete\" button with empty text box!", preferredStyle: .alert)
        var deleteTextField: UITextField!
        
        deleteShortcutAlert.addTextField { textField in
            deleteTextField = textField
            deleteTextField.placeholder = "Type \"Delete\" to accept!"
        }
        
        
        
        
        
        
        let addAction = UIAlertAction(title: "Delete -> 🗑?", style: .destructive) { [self] _ in
            
            if deleteTextField.text?.lowercased() == "delete"{
                self.topics.remove(at: (self.topics.firstIndex(of: selectedTopic) ?? self.topics.firstIndex(of: self.topics.last!))!)
                self.dataPickerView.reloadAllComponents()
                
            }else{
                deleteTextField.placeholder = "You mustenter \"Delete\", to delete selected item!"
            }
        }
        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        deleteShortcutAlert.addAction(addAction)
//        deleteShortcutAlert.addAction(cancelAction)
        
        present(deleteShortcutAlert, animated: true, completion: nil)
        
    }
    
    
    func addShortcutToDataPicker() {
        let addShortcutAlert = UIAlertController(title: "Add  a new shortcut", message: "Enter a new shortcut to access from Picker View!", preferredStyle: .alert)
        var shortcutTextField: UITextField!
        
        let addAction = UIAlertAction(title: "✚", style: .default) { [self] _ in
            guard let newItem = shortcutTextField.text, !newItem.isEmpty else { return }
            
            if self.topics.contains(newItem.lowercased()) {
                print("Element already exist!")
            }else{
                self.topics.append(newItem.lowercased())
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
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row].capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTopic = topics[row]
    }


}

