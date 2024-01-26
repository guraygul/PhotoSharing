//
//  SettingsViewController.swift
//  PhotoSharing
//
//  Created by Güray Gül on 26.01.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
}
