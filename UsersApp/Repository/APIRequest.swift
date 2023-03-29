//
//  APIRequest.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation

struct APIManager {
    
   static func makeAPIRequestCall<T: Codable>(url:URL, httpMethod:String, completionHandler: @escaping (Result<T, Error>)-> Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else{
                let error = NSError(domain: "com.example.network", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completionHandler(.failure(error))
                return

            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completionHandler(.success(decodedData))
            }catch{
                completionHandler(.failure(error))
            }
        }.resume()
        
    }
    
}



