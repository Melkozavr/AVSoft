//
//  ViewController.swift
//  AV_Soft_Swift
//
//  Created by Melkozavr on 07.04.2020.
//  Copyright © 2020 Melkozavr. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var UserTextField: UITextField!
    
    @IBOutlet weak var PassTextField: UITextField!
    
    @IBOutlet weak var Loading: UIProgressView!
    
    var currentTime: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserTextField.layer.cornerRadius = 5
        UserTextField.layer.borderWidth = 1
        UserTextField.layer.borderColor = (UIColor.black.cgColor)
        
        PassTextField.layer.cornerRadius = 5
        PassTextField.layer.borderWidth = 1
        PassTextField.layer.borderColor = (UIColor.black.cgColor)
        
        Loading.setProgress(currentTime, animated: true)
        
        addUsers("Marat", "123")
        addUsers("Sergei", "qwe")
        addUsers("Roman", "asd")
    }


}

// MARK: Save Core Data

extension ViewController: UITextFieldDelegate {

    func addUsers(_ username: String, _ password: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
    }
}

// MARK: Push "Sign in" Button and segue to another ViewController

extension ViewController {
    
    @IBAction func SignInButton(_ sender: UIButton) {
        print("Sign in button has been tapped!")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var accessFlag = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "username") as! String == UserTextField.text! && data.value(forKey: "password") as! String == PassTextField.text! {
                    accessFlag = 1
                }
            }
            
        } catch {
            print("Failed")
        }
        if accessFlag == 1 {
            if Loading.progress != 1.0 {
                perform(#selector(updateProgress), with: nil, afterDelay: 0.03)
            }
        }
        if UserTextField.text != "" && PassTextField.text != ""{
            if accessFlag == 1 {
                if Loading.progress == 1.0 {
                    currentTime = 0.0
                    UserTextField.text = ""
                    PassTextField.text = ""
                    Loading.setProgress(currentTime, animated: true)
                } else {
                    let alert = UIAlertController(title: "Wait some more", message: "Loading in progress", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                    let alert = UIAlertController(title: "Error!", message: "Password or Login are incorrect", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error!", message: "Fill the TextFields", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func updateProgress() {
        currentTime += 1.0
        
        Loading.progress = currentTime / 100.0
        if currentTime < 100.0 {
            perform(#selector(updateProgress), with: nil, afterDelay: 0.03)
        } else {
            currentTime = 0.0
        }
    }
}
