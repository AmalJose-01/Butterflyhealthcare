//
//  CommonFontSwiftClass.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 29/12/2023.
//


import Foundation
import UIKit
//import Alamofire
//import AppAuth


public class CommonNetworkSwiftClass: NSObject {
    
//    private var authState: OIDAuthState?
    
}


extension CommonNetworkSwiftClass  {
    
    @objc func callGetOrPostWebServiceHavingUnknownReturnTypeWithoutXAgency_AutoRefresh ( urlString : String, httpMethod: String , inputdata: Data , completion: @escaping ((_ result: [String:AnyObject] , _ outputData: Data?) ->Void))
    {
//        self.authState = LoginSingletonSwiftClass.shared.getOIDAuthState()
//        let currentAccessToken: String? = self.authState?.lastTokenResponse?.accessToken
//        self.authState?.performAction() { (accessToken, idToken, error) in
//            if error != nil  {
//                //self.logMessage("Error fetching fresh tokens: \(error?.localizedDescription ?? "ERROR")")
//                var errorResponse = [String : AnyObject]()
//                errorResponse["Error"] = (error?.localizedDescription ?? "ERROR") as AnyObject?
//                errorResponse["ReturnStatus"] = 0 as AnyObject?
//                errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
//                completion(errorResponse,Data())
//                return
//            }
//            guard let accessToken = accessToken else {
//                //Error getting accessToken
//                var errorResponse = [String : AnyObject]()
//                errorResponse["Error"] = "Error getting accessToken" as AnyObject?
//                errorResponse["ReturnStatus"] = 0 as AnyObject?
//                errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
//                completion(errorResponse,Data())
//                return
//            }
//            if currentAccessToken != accessToken {
//                //Access token was refreshed automatically
//            } else {
//                //Access token was fresh and not updated
//            }
//            LoginSingletonSwiftClass.shared.setAccessToken(token: accessToken)
//            let agencyCode = eVeroVisitUrls.defaultAgencyCodeForICMConnection.rawValue
//            print ("accessToken:")
//            print (accessToken)
            let bearerString = "Bearer "
            let authorization = bearerString + "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZTBiYWMzNjJjYTkwNzA0MDc1OTRhYWJjMjcwNTVhNSIsInN1YiI6IjY1OGY3NWY1ZWZjZWE5MDFmNWY5ZWVjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.giLwC2hqd_0O9ShK8gaHSHRXXy8Pg6-hjDzLFU5nsQA"
            
            guard let url = URL(string: urlString) else {
                return
            }
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
/*            */request.httpBody = inputdata
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if error != nil || data == nil {
                    print("Client error!")
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Unable to connect to server. Please check your internet connection." as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                }
                if let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Server error!" as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                    return
                }
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Wrong MIME type!" as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Issue" as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                    return
                }
                let myResponse = response
                if myResponse.statusCode != 200 {
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Issue" as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                    return
                }
                if error != nil{
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Issue" as AnyObject?
                    print("JSON error: \(error!.localizedDescription)")
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                    return
                }
                do {
                    if (try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]]) != nil {
                        print(" Success- The return data type is an Array  ")
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]]
                        print(json as Any)
                        var successResponse = [String : AnyObject]()
                        successResponse["Result"] = json as AnyObject?
                        successResponse["ReturnStatus"] = 1 as AnyObject?
                        successResponse["ReturnTypeIsDictionary"] = 0 as AnyObject?
                        completion(successResponse,data)
                    }else{
                        print(" Error- The return data type is not an Array  ")
                        if (try JSONSerialization.jsonObject(with: data!) as? [String:Any]) != nil{
                            print(" Success- The return data type is an Dictionary  ")
                            let json = try JSONSerialization.jsonObject(with: data!) as? [String:Any]
                            var successResponse = [String : AnyObject]()
                            successResponse["Result"] = json as AnyObject?
                            successResponse["ReturnStatus"] = 1 as AnyObject?
                            successResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                            completion(successResponse,data)
                        }else{
                            print(" Error- The return data type is an Dictionary  ")
                            var errorResponse = [String : AnyObject]()
                            errorResponse["Error"] = "Issue" as AnyObject?
                            errorResponse["ReturnStatus"] = 0 as AnyObject?
                            errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                            completion(errorResponse,data)
                        }
                    }
                } catch {
                    print("Error -> \(error)")
                    var errorResponse = [String : AnyObject]()
                    errorResponse["Error"] = "Issue" as AnyObject?
                    errorResponse["ReturnStatus"] = 0 as AnyObject?
                    errorResponse["ReturnTypeIsDictionary"] = 1 as AnyObject?
                    completion(errorResponse,data)
                }
                
            })
            task.resume()
        }
}
    
    
