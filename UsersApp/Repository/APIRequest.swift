//
//  APIRequest.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation

struct APIManager {
    
   static func makeAPIRequestCall<T: Codable>(url:URL, httpMethod:String, bodyData: Data?, completionHandler: @escaping (Result<T, Error>)-> Void){
        
       var request = URLRequest(url: url)
           request.httpMethod = httpMethod
           
           if let bodyData = bodyData {
               request.httpBody = bodyData
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           }
       print("Url: \(request.url!), body: \(bodyData!)")
       
       URLSession.shared.dataTask(with: request) { data, response, error in
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



