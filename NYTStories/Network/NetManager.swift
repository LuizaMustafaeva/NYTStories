//
//  NetManager.swift
//  NYTStories
//
//  Created by Luiza on 10.03.2021.
//  Copyright © 2021 Luiza. All rights reserved.
//

import Foundation

class NetManager {
    
    var newStories: Stories?
    
    func doRequest(name: String, completion: @escaping(_ stories: Stories) -> Void){

        let key = "pQVbavHYAoGUTUS32VQfwm1rtBGp0lfb"
        let urlStory = "https://api.nytimes.com/svc/topstories/v2/\(name).json?api-key=" + key
        
        guard let url = URL(string: urlStory) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data{
                self.parseJSON(withData: data)
                guard let newStories = self.newStories else { return }
                
                DispatchQueue.main.async {
                    completion(newStories)
                }
            }
        }
        task.resume()
    }
    
    
    func parseJSON(withData data: Data){
        
        let decoder = JSONDecoder()
        
        do {
            
            let stories = try decoder.decode(Stories.self, from: data)
            newStories = stories
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}
