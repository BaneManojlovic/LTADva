//
//  BaseAPI.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation
import Alamofire


//3.
enum APIError: Error {
    
    case noInternet
    case response(String)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "No Internet"
        case .unknown:
            return "Unknown error has occured"
        case .response:
            return ""
        default:
            return ""
        }
    }
}



// MARK: - Server failure block type
typealias APIFailure = (APIError) -> Void

// MARK: - BaseAPI protocol
protocol BaseAPI: class {
    
    var baseURL: URL { get }
    
    /// API success block
    typealias ApiRequestSuccess<DataType> = (_ data: DataType?, _ message: String?) -> Void
    
    /// API failure block
    typealias ApiRequestFailure = (_ error: APIError) -> Void
    
    /// API Request block
    typealias ApiRequestBlock = (Request?) -> Void
}

extension BaseAPI {
    
    @discardableResult
    func sendRequest<ResponseDataType>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil,
        success: @escaping ApiRequestSuccess<ResponseDataType>,
        failure: @escaping ApiRequestFailure) -> Request?
        where ResponseDataType: Decodable
    {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else { return nil }
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 20
        
        return sessionManager
            .request(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headers)
            .responseJSON(completionHandler: { [weak self] (response) in
                self?.logToConsole(response: response)
            })
//            .responseData(completionHandler: { [weak self] (response) in
//                self?.completionHandler(response: response, success: success, failure: failure)
//            })
    }
    
    @discardableResult
    func sendPOSTRequest<RequestDataType, ResponseDataType>(
        endpoint: String,
        model: RequestDataType,
        headers: HTTPHeaders? = nil,
        success: @escaping ApiRequestSuccess<ResponseDataType>,
        failure: @escaping ApiRequestFailure) -> Request?
        where RequestDataType: RequestModel, ResponseDataType: Decodable
    {
        
        guard let url = URL(string: endpoint, relativeTo: baseURL) else { return nil }
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.timeoutIntervalForRequest = 20
        
        return sessionManager
            .postRequest(url, parameters: model, headers: headers)?
            .responseJSON(completionHandler: { [weak self] (response) in
                self?.logToConsole(response: response)
            })
//            .responseData(completionHandler: { [weak self] response in
//                self?.completionHandler(response: response, success: success, failure: failure)
//            })
    }
    
    
    // MARK: - For writing log to console
    func logToConsole(response: DataResponse<Any>) {
        // Log Request
        if let urlRequest = response.request?.urlRequest {
            debugPrint("---------- REQUEST ----------")
            if let absoluteString = urlRequest.url?.absoluteString {
                debugPrint("URL: \(absoluteString)")
            }
            if let headers = urlRequest.allHTTPHeaderFields {
                debugPrint("HEADERS: \(headers)")
            }
            if let httpBody = urlRequest.httpBody {
                do {
                    debugPrint("PARAMETERS")
                    let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                    debugPrint(json)
                } catch { }
            }
        }
        
        // Log Response
        if let result = response.result.value {
            debugPrint("---------- RESPONSE ----------")
            debugPrint(result)
        }
    }
    
   // MARK: - Completion Handler Private functions
    /*
    private func completionHandler<ResponseDataType: Decodable>(// swiftlint:disable:this function_body_length
        response: DataResponse<Data>,
        success: @escaping ApiRequestSuccess<ResponseDataType>,
        failure: @escaping ApiRequestFailure)
    {
        let statusCode = response.response?.statusCode ?? 400
        if 200..<300 ~= statusCode {
            // success
            guard let data = response.result.value else {
                failure(.unknown)
                return
            }
            
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [.allowFragments])
                debugPrint(jsonResponse) //Response result
            } catch let parsingError {
                debugPrint("Error", parsingError)
            }
            
            do {
                
                let defaultResponse = try CustomJSONDecoder().decode(DefaultResponse<ResponseDataType>.self, from: data)
                
                guard defaultResponse.status != "error" else {
                    if let message = defaultResponse.message {
                        debugPrint(message)
                        failure(.response(message))
                    } else {
                        failure(.unknown)
                    }
                    return
                }
                
                success(defaultResponse.data, defaultResponse.message)
                return
            } catch {
                debugPrint(error)
                debugPrint(error.localizedDescription)
                failure(.general(error.localizedDescription))
            }
            // failure
        } else if statusCode == 400, let data = response.result.value {
            do {
                let defaultResponse = try CustomJSONDecoder().decode(ValidationResponse.self, from: data)
                if let validationError = defaultResponse.validation {
                    if validationError.token?.isEmpty != nil {
                        failure(.unauthorized)
                        return
                    }
                    failure(.validation(validationError))
                    return
                } else {
                    failure(.unknown)
                    return
                }
            } catch {
                debugPrint(error)
                failure(.general(error.localizedDescription))
                return
            }
        } else {
            if let error = response.error as? URLError, error.code == URLError.Code.notConnectedToInternet {
                failure (.noInternet)
            } else if let error = response.error as? URLError, error.code == URLError.Code.cancelled {
                failure(.canceled)
            } else if let error = response.result.error {
                failure(.response(error.localizedDescription))
            } else {
                failure(.unknown)
                
            }
        }
    }
    */
}




struct EmptyResponse: Decodable { }

protocol RequestModel: Encodable { }
