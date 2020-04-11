//
//  ToolbarViewController.swift
//  AV_Soft_Swift
//
//  Created by Melkozavr on 07.04.2020.
//  Copyright © 2020 Melkozavr. All rights reserved.
//

import Foundation
import UIKit

class ToolbarViewController: UIViewController {
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuOut = false

    @IBOutlet weak var aboutProgramTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func animation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:  {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        menuOut = false
        animation()
    }
    
    @IBAction func showButton(_ sender: UIButton) {
        leading.constant = 0
        trailing.constant = 0
        menuOut = false
        animation()
    }
    
    @IBAction func aboutProgramButton(_ sender: UIButton) {
        let link: URL = URL(string: "https://github.com/Melkozavr")!
        
        aboutProgramTextView.text = """
        Created by Marat Usmanov.
        Github: \(link)
        """
        leading.constant = 0
        trailing.constant = 0
        menuOut = false
        animation()
    }
    
    @IBAction func toolBarButton(_ sender: UIButton) {
        
        if menuOut == false {
            leading.constant = 200
            trailing.constant = -200
            menuOut = true
        } else {
            leading.constant = 0
            trailing.constant = 0
            menuOut = false
        }
        animation()
    }
}
