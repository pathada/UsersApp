//
//  AllUsersResponse.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation


//All Users

struct AllUsers:Codable {
    var users:[Users]
}

struct Users:Codable {
    var id: Int?
    var username: String?
    var firstName:String?
    var lastName:String?
    var maidenName:String?
    var email:String?
    var image:String?
    var gender:String?
    var age:Int?
    var phone:String?
    var birthDate:String?
    var bloodGroup:String?
    var address:Address
}

struct Address {
    var address:String?
    var city:Int?
    var postalCode:String?
    var state:String?
    var coordinates:Coordinates
}
struct Coordinates {
    var lat:Double?
    var lng:Double?
}
