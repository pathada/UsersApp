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
        usernameTxtFld.text = "kminchelle"
        passwordTxtFld.text = "0lelplR"
    }
    
    @IBAction func loginAction(_ sender: Any) {
        /*
        guard let username = usernameTxtFld.text, username.isEmpty,
              let password = passwordTxtFld.text, password.isEmpty else {
            // handle case where one or both text fields are empty
            return
        }
         */
        
        if let username = usernameTxtFld.text, !username.isEmpty, let password = passwordTxtFld.text, !password.isEmpty{
            loginApiRequest(userName: usernameTxtFld.text ?? "", password: passwordTxtFld.text ?? "")
        }else{
            Alert.showAlertView(message: "Please enter the credentials", vc: self)

        }
        
    }
    
    func loginApiRequest(userName:String, password:String){
        let urlStr = Urls.baseURL.appending(Urls.secondURL.login.rawValue)

        //Converting string to URL
        guard let url = URL(string: urlStr) else {
            return
        }
        
        //JSON parameters
        let body = LoginRequestBody(username: userName, password: password)
        //Encoding the body to jsondata
        let jsonData = try? JSONEncoder().encode(body)
        APIManager.shared.makeAPIRequestCall(url: url, httpMethod: HTTPMethod.post, bodyData: jsonData) { (result: Result<LoginResponse, Error>) in
                switch result{
                case .success(let responseData):
                    print("success response data: \(responseData)")
                    self.loginSuccessApiResponse(response: responseData)
                case .failure(let error):
                    print("Failed: \(error)")
                    DispatchQueue.main.async {
                        // Update UI here
                        Alert.showAlertView(message: "Invalid Credentials", vc: self)
                    }

                    
                }
            }

    }
    func loginSuccessApiResponse(response:LoginResponse){
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: constants.storyBoards.usersList.rawValue, bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: constants.viewControllers.usersList.rawValue) as! UsersListViewController
                nextViewController.loginObj = response
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
       /*
        DispatchQueue.main.async {
            NavigateToNextVC.navigateToViewController(withIdentifier: constants.viewControllers.usersList.rawValue, storyboardName: constants.storyBoards.usersList.rawValue, from: self)
        }
        */
    }
    
}
