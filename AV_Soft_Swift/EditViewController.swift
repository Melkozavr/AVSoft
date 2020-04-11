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
    
    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileName = "DocumentsDirectory.txt"
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var descrTextView: UITextView!
    
    func checkDirectory() -> String? {
        do {
            let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDir)
            
            let files = filesInDirectory
            if files.count > 0 {
                if files.first == fileName {
                    print("DocumentsDirectory.txt found")
                    return files.first
                } else {
                    print("DocumentsDirectory.txt not found")
                    return nil
                }
            }
        } catch let error as NSError {
        print(error)
        }
        return nil
    }
    @IBAction func writeButton(_ sender: UIButton) {
        if nameTextField.text == "" || lastNameTextField.text == "" {
            let alert = UIAlertController(title: "Error!", message: "First name and last name columns must be filled", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let contentsOfFile = """
        \(nameTextField.text!)
        \(lastNameTextField.text!)
        \(descrTextView.text!)
        ----------------------------
        """
        
        do {
            try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            print("Text added into file")
        } catch let error as NSError {
            print("could't add text into file because of error: \(error)")
        }
    }

}
