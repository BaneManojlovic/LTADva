//
//  APIManager.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

//2.
final class APIManager {
    
    var baseURL: URL = Config.instance.apiURL
    
    static var `default` = APIManager()
    
    private enum Endpoint {
        static let login = "api/log-in"
        static let signUp = "api/sign-up"
        static let deviceToken = "api/device-token"
    }
    
    
}
