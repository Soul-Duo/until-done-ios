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

    }
    
    //function called once the user hits the return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        return true
    }
    
    @IBAction func saveTask(){
        
    }


}
