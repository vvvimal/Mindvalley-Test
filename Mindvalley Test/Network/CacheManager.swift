//
//  CacheManager.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit

//private var _SharedInstance: CacheManager? = nil
fileprivate let dataCache = NSCache<NSString, NSData>()

class CacheManager {

    private static var sharedInstance:CacheManager!
//    class func setup(costLimit:Int, countLimit:Int, isDiscardableContent:Bool){
//        if _SharedInstance == nil {
//            _SharedInstance = CacheManager(costLimit:costLimit, countLimit:countLimit, isDiscardableContent:isDiscardableContent)
//        }
//
//    }
    
    static func shared(costLimit:Int? = nil, countLimit:Int? = nil, isDiscardableContent:Bool? = false) -> CacheManager{
        if sharedInstance != nil{
            return sharedInstance
        }
        else{
            sharedInstance = CacheManager()
            if let costValue = costLimit {
                dataCache.totalCostLimit = costValue
            }
            if let countValue = countLimit{
                dataCache.countLimit = countValue
            }
            if let discardFlag = isDiscardableContent{
                dataCache.evictsObjectsWithDiscardedContent = discardFlag
            }
            return sharedInstance
        }
    }
    
//    static var sharedInstance: CacheManager? {
//        if _SharedInstance == nil {
//            _SharedInstance = CacheManager()
//        }
//        return _SharedInstance
//    }
    
//    private init(costLimit:Int, countLimit:Int, isDiscardableContent:Bool) {
//        self.dataCache.totalCostLimit = costLimit
//        self.dataCache.countLimit = countLimit
//        self.dataCache.evictsObjectsWithDiscardedContent = isDiscardableContent
//    }
    
    private init() {
        
    }
    
    func setObject(data:NSData, forKey key:NSString){
        dataCache.setObject(data, forKey: key)
    }
    
    func object(forKey key:NSString) -> NSData?{
        return dataCache.object(forKey: key)
    }
}
