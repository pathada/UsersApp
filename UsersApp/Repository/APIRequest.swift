//
//  APIRequest.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/29/23.
//

import Foundation
import UIKit

class APIManager {
    
    static let shared = APIManager()

    /// This is to make API network call
    func makeAPIRequestCall<T: Codable>(url:URL, httpMethod: HTTPMethod, bodyData: Data?, completionHandler: @escaping (Result<T, Error>)-> Void){
        
       var request = URLRequest(url: url)
       request.httpMethod = httpMethod.rawValue
           
           if let bodyData = bodyData {
               request.httpBody = bodyData
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           }
       
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
    
    func downloadImage(_ urlString: String, completion: @escaping (_ image: UIImage?, _ urlString: String?) -> ()) {
       guard let url = URL(string: urlString) else {
          completion(nil, urlString)
          return
       }
       
       URLSession.shared.dataTask(with: url) { (data, response, error) in
          // handle errors
          guard error == nil, let data = data else {
             completion(nil, urlString)
             return
          }
          
          // decode the image
          let image = UIImage(data: data)
           DispatchQueue.main.async {
               
               completion(image, urlString)
           }
       }.resume()
    }
    
}



