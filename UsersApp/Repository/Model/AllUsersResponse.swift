//
//  AllUsersResponse.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation


//All Users

struct AllUsersResponse:Codable {
    let users:[userInfo?]
}

//SingleUser
struct userInfo:Codable {
    let id: Int?
    let username: String?
    let firstName:String?
    let lastName:String?
    let maidenName:String?
    let email:String?
    let image:String?
    let gender:String?
    let age:Int?
    let phone:String?
    let birthDate:String?
    let bloodGroup:String?
    let address:AddressInfo?
    let bank:BankInfo?
    let company:CompanyInfo?
    
}

struct AddressInfo:Codable {
    let address:String?
    let city:String?
    let postalCode:String?
    let state:String?
    let coordinates:CoordinatesInfo?
}
struct CoordinatesInfo:Codable {
    let lat:Double?
    let lng:Double?
}
struct BankInfo:Codable {
    let cardExpire:String?
    let cardNumber:String?
    let cardType:String?
    let currency:String?
    let iban:String?
}
struct CompanyInfo:Codable {
    let name:String?
    let title:String?
    let address:AddressInfo?
    let department:String?
    
}

