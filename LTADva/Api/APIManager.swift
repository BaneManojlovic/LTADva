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
final class APIManager: BaseAPI {
    
    var baseURL: URL = Config.instance.apiURL
    
    static var `default` = APIManager()
    
    private enum Endpoint {
        static let login = "api/log-in"
        static let signUp = "api/sign-up"
        static let deviceToken = "api/device-token"
    }
    
    // MARK: - Function for registration of the user
    typealias RegisterSuccess = () -> Void
    func register(
        requestModel: RegisterRequestModel,
        success: @escaping RegisterSuccess,
        failure: @escaping APIFailure)
    {
        sendPOSTRequest(
            endpoint: Endpoint.signUp,
            model: requestModel,
            success: { (_: EmptyResponse?, _) in
                success()
        }, failure: failure)
    }
    
}
