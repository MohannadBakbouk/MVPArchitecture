//
//  ApiService.swift
//  MVPArchitecture
//
//  Created by Mohannad on 11/10/20.
//

import Foundation

protocol ProAPIManager{
    
    func fetchPosts(page : Int  , completion : @escaping (PostsResponse?)->())
    
    func fetchUsers()
}


class APIManager  : NSObject , ProAPIManager {
  
    
    static let shared = APIManager()
    
    func fetchPosts(page : Int = 0 , completion : @escaping (PostsResponse?)->()) {
        
         var urlComp = URLComponents(string:"\(Constants.identifiers.apiUrl)/post")!
        
         urlComp.queryItems = [URLQueryItem(name: "page", value: String(page))]
        
         var request = URLRequest(url: urlComp.url!)
         
         request.httpMethod = "Get"
        
         request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
          
         request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        request.setValue(Constants.identifiers.apiKey, forHTTPHeaderField: "app-id")
             
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
             
             guard let data = data , error == nil else {
                 print("error while fetching posts \(error)")
                 completion(nil)
                 return
             }
            
             let posts = try? JSONDecoder().decode(PostsResponse.self, from: data)
            
              completion(posts)
         }
             
     task.resume()
    }
    
    func fetchUsers() {
        
    }
    
    
}
