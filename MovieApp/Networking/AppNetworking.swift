//
//  AppNetworking.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//


import Foundation
import SwiftyJSON
import Alamofire
import Photos

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias HTTPHeaders = [String:String]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (Error) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
//typealias UserControllerSuccess = (_ user : UserModel) -> ()
typealias DownloadData = (_ data : Data) -> ()
typealias UploadFileParameter = (fileName: String, key: String, data: Data, mimeType: String)

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
    static var timeOutInterval = TimeInterval(30)
    
    private static func executeRequest(jsonType: JSONType = .jsonDict ,_ request: NSMutableURLRequest, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        let session = URLSession.shared
        
        session.configuration.timeoutIntervalForRequest = timeOutInterval
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error == nil) {
                
                do {
                    if let jsonData = data {
                        
                        if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                            
                            print(jsonDataDict)
                            DispatchQueue.main.async(execute: { () -> Void in
                                
                                success(JSON(jsonDataDict))
                            })
                        }
                        
                    }else{
                        let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data found"])
                        failure(error)
                    }
                } catch let err as NSError {
                    
                    let responseString = String(data: data!, encoding: .utf8)
                    print("responseString = \(responseString ?? "")")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                }
                if let err = error {
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                }else{
                    let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Something went wrong"])
                    failure(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
 
    
    private static func REQUEST(withUrl url : URL?,jsonType: JSONType = .jsonDict ,method : String,postData : Data?,header : [String:String],loader : Bool, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
        
        guard let url = url else {
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Url or parameters not valid"])
            failure(error)
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method
        
        var updatedHeaders = header
        updatedHeaders[ApiKey.authorization.rawValue] =  AppConstant.token.rawValue
        updatedHeaders["Language"] = "en"
        request.allHTTPHeaderFields = updatedHeaders
        request.allHTTPHeaderFields?.removeValue(forKey: "Content-Type")
        request.allHTTPHeaderFields?.removeValue(forKey: "Accept")
        request.httpBody = postData
        executeRequest(jsonType: jsonType, request, { (json) in
            success(json)
        }, { (err) in
           
            failure(err)
        })
    }
    
    static func GET(endPoint : String,
                    parameters : [String : Any] = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    requireAccesstoken: Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUEST(withUrl: uri,
                method: "GET",
                postData : nil,
                header: headers,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    
    static private func encodeParamaters(params : [String : Any]) -> String {
        
        var result = ""
        
        for key in params.keys {
            
            result.append(key+"=\(params[key] ?? "")&")
            
        }
        
        if !result.isEmpty {
            result.remove(at: result.index(before: result.endIndex))
        }
        
        return result
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}


extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

