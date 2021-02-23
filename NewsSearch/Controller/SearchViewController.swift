//
//  ViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    //MARK: - Variables && Outlets
    var topics = ["bitcoin", "apple", "tesla", "bmw", "volvo", "audi", "amazon", "telegram", "facebook", "whatsapp", "windows", "android "].sorted()
    
    var selectedTopic = String()
    var saveLastIndex = 0
    
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var manualSearchTextField: UITextField!
    @IBOutlet weak var shortcutSearchButton: UIButton!
    @IBOutlet weak var keywordSearchButton: UIButton!
    @IBOutlet weak var searchButtonInfoLabel: UILabel!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - View will appear
    override func viewWillAppear(_ animated: Bool) {
        manualSearchTextField.text = nil
    }
    
    //MARK: - Search buttons
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
    
    //MARK: - Delete && Edit buttons
    @IBAction func navigationBarDeleteButtonPressed(_ sender: Any) {
        deleteItem()
    }
    
    @IBAction func navigationBarAddButtonIsPressed(_ sender: Any) {
        addShortcutToDataPicker()
    }
    

    



}

