//
//  RequestManager.swift
//  NewProject
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021. All rights reserved.
//

import UIKit
import Alamofire

/// To Hold request parameter values
struct Request {
    
    /// To Hold actual parameter values
    struct Parameter {
        
        static let weatherQ = "q"
        static let latitude = "lat"
        static let longitude = "lon"        
        static let appid = "appid"
    }
    
    /// To Hold actual methods values
    struct Method {
        static let reverseGeocode = "geo/1.0/reverse"
        static let weather = "data/2.5/weather"
    }    
}

/// To Hold status values
struct Status {
    
    /// To Hold status code values
    struct Code {
        static let success = 200
        static let unauthorized = 401
        static let notfound = 404
        static let sessionExpired = 500
    }
}

/// Rest API request call
class RequestManager: NSObject {
    
    /// single instacne of RequestManager
    static var shared = RequestManager()
    
    /// It is used to check the network reachable or not
    fileprivate var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    //------------------------------------------------------
    
    //MARK: Background Task
    
    /// Keep hold background task identity UIBackgroundTaskIdentifier
    var backgroundTask = UIBackgroundTaskIdentifier.invalid
    
    /// Execute task in background
    /// - Parameter requestMethod: request url in String
    fileprivate func backgroundFetch(_ requestMethod: String) {
        let app = UIApplication.shared
        let endBackgroundTask = {
            if self.backgroundTask != UIBackgroundTaskIdentifier.invalid {
                app.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
        backgroundTask = app.beginBackgroundTask(withName: String(format: "%@.%@", kAppBundleIdentifier, requestMethod)) {
            endBackgroundTask()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: GENERAL       
    
    /// Request Get
    /// - Parameters:
    ///   - type: Declare Decodable Type
    ///   - requestMethod: Request Method
    ///   - parameter: Request Parameter
    ///   - decodingType: Decodable Class Type
    ///   - successBlock: Success callback execution
    ///   - failureBlock: Failure callback execution
    fileprivate func requestREST<T: Decodable>(type: HTTPMethod, requestMethod : String, parameter : [String : Any], decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
                 
        var requestURL: String = String()
        var headers: HTTPHeaders = [:]
        headers["content-type"] = "application/json"
        /*if type == .post {
            headers["content-type"] = "application/x-www-form-urlencoded"
        }*/
        requestURL = PreferenceManager.shared.baseURL.appending(requestMethod)
        
        debugPrint("----------- \(requestMethod) ---------")
        debugPrint("requestURL:\(requestURL)")
        debugPrint("requestHeader:\(headers)")
        debugPrint("parameter:\(parameter.dict2json())")
             
        backgroundFetch(requestMethod)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let encodingType: ParameterEncoding = (type == HTTPMethod.post) ? JSONEncoding.default : URLEncoding.default
        request(requestURL, method: type, parameters: parameter, encoding: encodingType, headers: headers).responseData { (response: DataResponse<Data>) in
            switch response.result {
            case .success:
                
                if let jsonData = response.result.value {
                    do {
                        let responseString = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                        debugPrint(".success:\(String(describing: responseString?.dict2json()))")
                        debugPrint("--------------------")
                        if response.response?.statusCode == Status.Code.success {
                            if jsonData.count > 0 {
                                let result = try JSONDecoder().decode(decodingType, from: jsonData)
                                successBlock(result)
                            } else {
                                let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                                let result = try JSONDecoder().decode(decodingType, from: emptyData)
                                successBlock(result)
                            }
                        } else {
                            let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                            let result = try JSONDecoder().decode(decodingType, from: emptyData)
                            successBlock(result)
                        }
                    } catch let error {
                        debugPrint(".failure:\(error.localizedDescription)")
                        debugPrint("--------------------")
                        let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                        failureBlock(errorModal)
                    }
                }
                break
            case .failure(let error):
                             
                debugPrint(".failure:\(error.localizedDescription)")
                debugPrint("--------------------")
                let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                failureBlock(errorModal)
                break
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: GET
     
    /// Request Get
    /// - Parameters:
    ///   - requestMethod: Request Method
    ///   - parameter: Request Parameter
    ///   - decodingType: Decodable Class Type
    ///   - successBlock: Success callback execution
    ///   - failureBlock: Failure callback execution
    func requestGET<T: Decodable>(requestMethod : String, parameter : [String : Any], decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        requestREST(type: HTTPMethod.get, requestMethod: requestMethod, parameter: parameter, decodingType: decodingType, successBlock: { (response: T) in
            
            successBlock(response)
            
        }, failureBlock: { (error: ErrorModal) in
            
            failureBlock(error)
        })
    }
    
    //------------------------------------------------------
}

