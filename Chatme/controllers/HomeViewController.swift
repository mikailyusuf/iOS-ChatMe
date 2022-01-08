//
//  HomeViewController.swift
//  Chatme
//
//  Created by Mikail on 08/01/2022.
//

import UIKit
import CLTypingLabel

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeText: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeText.text = "Welcome To Chatme"
        // Do any additional setup after loading the view.
    }
    

}
