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
        shortcutSearchButton.isEnabled = false
        view.endEditing(true)
    }
    
    @IBAction func primarryActionTriggered(_ sender: Any) {
        textfieldActionManager()
    }
    
    
    //MARK: - Search buttons
    @IBAction func manualSearchButtonPressed(_ sender: Any) {
        textfieldActionManager()
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
            
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
            let titleImageView = UIImageView(image: UIImage(systemName: "keyboard"))
            titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
            titleView.addSubview(titleImageView)
            navigationItem.titleView = titleView
        }
    }

    @objc func keyboardWillHide(notification: Notification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 10
            navigationItem.titleView?.isHidden = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    

}

