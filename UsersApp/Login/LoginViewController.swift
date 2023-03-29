//
//  ViewController.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        print("baseurl: \(constants.baseURL+constants.secondURL.login.rawValue)")
    }
    
}

