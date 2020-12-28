//
//  EntryViewController.swift
//  UntilDone
//
//  Created by Kevin Kim on 2020/12/28.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))

    }
    
    //function called once the user hits the return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        
        //just return if text field is empty
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        
        
    }


}
