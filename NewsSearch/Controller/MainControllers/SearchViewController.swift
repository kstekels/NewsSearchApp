//
//  ViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit
import RealmSwift


class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let storage         = StorageManager()
    let articleStorage  = ArticleStorageManager()

    //MARK: - Variables && Outlets
    
    var selectedTopic       = String()
    var saveLastIndex       = 0
    let notificationCenter  = NotificationCenter.default
    let userDefaults        = UserDefaults.standard
    
    @IBOutlet weak var dataPickerView           : UIPickerView!
    @IBOutlet weak var manualSearchTextField    : UITextField!
    @IBOutlet weak var shortcutSearchButton     : UIButton!
    @IBOutlet weak var keywordSearchButton      : UIButton!
    @IBOutlet weak var searchButtonInfoLabel    : UILabel!
    

    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setupView()
        storage.loadKeywords()
        requestNotificationAuthorization()
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
        infoButtonAlert()
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
    

}

