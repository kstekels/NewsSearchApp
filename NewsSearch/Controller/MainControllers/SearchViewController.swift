//
//  ViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit
import RealmSwift


class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let storage = StorageManager()
    let articleStorage = ArticleStorageManager()

    //MARK: - Variables && Outlets
    
    var selectedTopic = String()
    var saveLastIndex = 0

    let notificationCenter = NotificationCenter.default
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var manualSearchTextField: UITextField!
    @IBOutlet weak var shortcutSearchButton: UIButton!
    @IBOutlet weak var keywordSearchButton: UIButton!
    @IBOutlet weak var searchButtonInfoLabel: UILabel!
    

    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search news"
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setupView()
        storage.loadKeywords()
        requestNotificationAuthorization()
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    

    //MARK: - View will appear
    override func viewWillAppear(_ animated: Bool) {
        manualSearchTextField.text = nil
        view.endEditing(true)
        
    }
    
    @IBAction func primarryActionTriggered(_ sender: Any) {
        textfieldActionManager()
    }
    
    
    //MARK: - Search buttons
    @IBAction func manualSearchButtonPressed(_ sender: Any) {
        textfieldActionManager()
    }
    
    //MARK: - Info
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Info!", message: "In this App you can search news by typing keywords in text field.\nAlternitive way is to use shortcuts!\nTo add new shortcut, press \"✚\"!\nIf you want delete shortcuts, just pick what you want to delete from picker view and press on trash can!\n", preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true)
    }
    
    
    func textfieldActionManager() {
        if manualSearchTextField.text == ""{
            manualSearchTextField.placeholder = "Please Enter a text!"
        }else{
            selectedTopic = manualSearchTextField.text!
            goToDetailedTableview()
        }
    }
    
    @IBAction func NewsShortcutButtonPressed(_ sender: Any) {
        if selectedTopic != " "{
            goToDetailedTableview()
        }
        
    }
    
    //MARK: - Delete && Edit buttons
    @IBAction func navigationBarDeleteButtonPressed(_ sender: Any) {
        deleteItem()
    }
    
    @IBAction func navigationBarAddButtonIsPressed(_ sender: Any) {
        addShortcutToDataPicker()
    }
    
    
    // moving keyboard
    @objc func keyboardWillShow(notification: Notification){
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 10
        }
    }

    @objc func keyboardWillHide(notification: Notification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 10
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    

}

