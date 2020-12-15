//
//  NetWorkTools.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/15.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetWorkTools {
    class func reqeustData(_ type: MethodType, urlString: String, params: [String : Any]? = nil, callBack: @escaping (_ result: Any) -> ()) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error as Any)
                return
            }
            
            callBack(result)
        }
    }
    
}
