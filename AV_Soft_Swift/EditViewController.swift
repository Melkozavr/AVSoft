//
//  EditViewController.swift
//  AV_Soft_Swift
//
//  Created by Melkozavr on 08.04.2020.
//  Copyright © 2020 Melkozavr. All rights reserved.
//

import Foundation
import UIKit

class EditViewController: UIViewController {
    
    let fileURLProject = Bundle.main.path(forResource: "DocumentsDirectory", ofType: "txt")
    var stringArr: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descrTextView: UITextView!
    
    @IBAction func addButton(_ sender: UIButton) {
        stringArr.append((nameTextField.text!, descrTextView.text!))
        var writeStr: String = ""
        
        for (name, descr) in stringArr {
            writeStr += "\(name)\n"
            writeStr += "\(descr)\n"
        }
                do {
                    //write to the file
                    try writeStr.write(toFile: fileURLProject!, atomically: true, encoding: String.Encoding.utf8)
                } catch let error as NSError {
                    print("Failed to write to URL")
                    print(error)
                }
        var readStrindProject = ""
        do {
            readStrindProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to read file")
            print(error)
        }
        print(readStrindProject)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        
    }
    
    
}
