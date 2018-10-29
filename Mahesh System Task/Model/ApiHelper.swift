//
//  ApiHelper.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import UIKit

class ApiHelper: NSObject {
    
    class func requestGetApi(apiString: String, success:@escaping (AnyObject) -> Void, failure:@escaping (String) -> Void) {
        let urlwithPercentEscapes = apiString.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let urlString = urlwithPercentEscapes, let url = URL(string: urlString) else {
            failure("error")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil, let error = error {
                failure(error.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                success(json as AnyObject)
            } catch {
                failure("error")
            }
            }.resume()
    }
}
