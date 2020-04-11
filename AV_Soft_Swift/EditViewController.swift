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
    
    func fillError() {
        if nameTextField.text! == "" || descrTextView.text! == "" {
            let alert = UIAlertController(title: "Error!", message: "Fill all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        fillError()
        var flag = false
        for elem in stringArr {
            if elem.0 == nameTextField.text! {
                flag = true
            }
        }
        if flag == true {
            let alert = UIAlertController(title: "Error!", message: "This person already exists", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
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
//            var readStrindProject = ""
//            do {
//                readStrindProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
//            } catch let error as NSError{
//                print("Failed to read file")
//                print(error)
//            }
//            print(readStrindProject)
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        fillError()
        var counter = 0
        var flag = false
        var writeStr: String = ""
        
        for elem in stringArr {
            counter += 1
            if elem.0 == nameTextField.text! {
                flag = true
                break
            }
        }
        if flag == true {
            stringArr.remove(at: counter - 1)
        }
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
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        fillError()
        var flag = false
        var counter = 0
        
        for elem in stringArr {
            if elem.0 == nameTextField.text! {
                flag = true
                break
            }
            counter += 1
        }
        if flag == false {
            let alert = UIAlertController(title: "Error!", message: "No such person", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            var writeStr: String = ""
            stringArr[counter] = (nameTextField.text!, descrTextView.text!)
        
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
        }
    }
    
    
}
