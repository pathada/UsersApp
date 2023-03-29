//
//  ConstantsFile.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation

struct constants {
    static let baseURL = "https://dummyjson.com/"
    
    enum secondURL:String{
        case login = "auth/login"
        case allUsers = "users"
        case singleUser = "users/"
        case searchUser = "users/search?q="

    }

}
