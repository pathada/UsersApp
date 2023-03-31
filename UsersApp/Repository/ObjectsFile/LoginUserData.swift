//
//  LoginUserData.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/30/23.
//

import Foundation
class LoginUserData {
    var id: Int?
    var username: String?
    var firstname:String?
    var lastname:String?
    var email:String?
    var image:String?
    var gender:String?
    
    init(username: String?, email: String?, id: Int?, firstname: String?, lastname: String?, image: String?, gender: String?) {
        self.username = username
        self.email = email
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.image = image
        self.gender = gender
    }
}
