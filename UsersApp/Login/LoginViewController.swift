//
//  ViewController.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import UIKit



struct LoginRequestBody: Codable {
    let username: String?
    let password: String?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameTxtFld.text = "atuny0"
        passwordTxtFld.text = "9uQFF1Lh"
    }
    
    @IBAction func loginAction(_ sender: Any) {
       loginApiRequest()
        
        
    }
    
    func loginApiRequest(){
        print("baseurl: \(constants.baseURL+constants.secondURL.login.rawValue)")
        let urlStr = constants.baseURL.appending(constants.secondURL.login.rawValue)

        guard let url = URL(string: urlStr) else {
            return
        }
        
        let httpMethod = HTTPMethod.post.rawValue
        
        let body = LoginRequestBody(username: usernameTxtFld.text, password: passwordTxtFld.text)
        let jsonData = try? JSONEncoder().encode(body)
        
            APIManager.makeAPIRequestCall(url: url, httpMethod: httpMethod, bodyData: jsonData) { (result: Result<LoginResponse, Error>) in
                switch result{
                case .success(let responseData):
                    print("success response data: \(responseData)")
                    self.loginSuccessApiResponse(response: responseData)
                case .failure(let error):
                    print("Failed: \(error)")
                }
            }

    }
    func loginSuccessApiResponse(response:LoginResponse){
        print("response: \(response)")
    }
    
}
