//
//  LoginResponse.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation


//Login
struct LoginResponse:Codable {
    var id: Int?
    var username: String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var image:String?
    var gender:String?
}

struct LoginRequestBody: Codable {
    let username: String?
    let password: String?
}



