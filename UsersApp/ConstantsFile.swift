//
//  ConstantsFile.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation
import UIKit


struct Urls {
    static let baseURL = "https://dummyjson.com/"
    
    enum secondURL:String{
        case login = "auth/login"
        case allUsers = "users"
        case singleUser = "users/"
        case searchUser = "users/search?q="

    }
}

struct constants {

    enum viewControllers:String{
        case login = "LoginViewController"
        case usersList = "UsersListViewController"
        case userDetails = "UserDetailViewController"
    }
    
    enum storyBoards:String{
        case login = "Main"
        case usersList = "UsersListStoryboard"
        case userDetails = "UserDetailStoryboard"


    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Alert {
     static func showAlertView(message:String, vc:UIViewController){
        // Create new Alert
         let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        // Present Alert to
        vc.present(dialogMessage, animated: true, completion: nil)
    }
}


struct NavigateToNextVC {
    static func navigateToViewController(withIdentifier identifier: String, storyboardName: String, from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        viewController.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
