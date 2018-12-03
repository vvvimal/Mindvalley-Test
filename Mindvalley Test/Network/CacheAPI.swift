//
//  CacheAPI.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 11/27/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit

import UIKit


extension NSError {
    static func generalParsingError(domain: String) -> Error {
        return NSError(domain: domain, code: 400, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Error retrieving data", comment: "General Parsing Error Description")])
    }
}

class CacheAPI {
    static let dataURLString = "http://pastebin.com/raw/wgkJgazE"
    
    //MARK: - Public
    
    class func getImagesDetails(completion:@escaping ([ImageDataModel], Error?) -> Void) {
        if let requestUrl = URL(string:dataURLString){
            self.getData(url: requestUrl, completion: {(data, error) in
                
                if error == nil,let usableData = data {
                    print(usableData) //JSONSerialization
                    do {
                        // Convert NSData to Dictionary where keys are of type String, and values are of any type
                        let json = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<Dictionary< String, Any>>
                        
                        // Access specific key with value of type String
                        print(json)
                        let imageDataArray = json.compactMap({ (imageDict) -> ImageDataModel? in
                            return ImageDataModel(response: imageDict as AnyObject)
                        })
                        completion(imageDataArray, nil)
                        
                    } catch {
                        // Something went wrong
                        completion([], NSError.generalParsingError(domain: requestUrl.absoluteString))
                    }
                    
                }
                else if error != nil {
                    print(error as Any)
                    completion([], error)
                    
                }
            })
        }

    }
    
    class func downloadImages(url:URL, completion:@escaping (UIImage?, Error?) -> Void) {
        self.getData(url: url, completion: {(data, error) in
            
            if error == nil, let usableData = data {
                if let image = UIImage.init(data: usableData as Data){
                    completion(image, nil)
                }
            }
            else if error != nil {
                print(error as Any)
                completion(nil, error)
                
            }
        })
        
    }
    
    fileprivate static func getData(url: URL, completion: @escaping (_ data: NSData?, _ error: Error? ) -> Void) {
        if let data = CacheManager.shared().object(forKey: url.absoluteString as NSString) {
            completion(data, nil)
        } else {
            CacheAPI.downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data as NSData? {
                    CacheManager.shared().setObject(data: data, forKey: url.absoluteString as NSString)
                    completion(data, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                }
            }
        }
    }
    
    //MARK: - Private
    fileprivate static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {

        URLSession(configuration: getDefaultSessionConfig()).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    fileprivate static func getDefaultSessionConfig()-> URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
        return sessionConfig
    }
    
}
