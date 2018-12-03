//
//  BaseDataModel.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class BaseDataModel {
    func getStringValueFrom(representation: AnyObject, for key:String) ->String? {
        if let value = representation[key] as? String{
            return value
        }
        return nil
    }
    
    func getIntValueFrom(representation: AnyObject, for key:String) ->Int? {
        if let value = representation[key] as? Int{
            return value
        }
        return nil
    }
    
    func getDateValueFrom(representation: AnyObject, for key:String) ->Date? {
        if let value = representation[key] as? String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let date: Date? = dateFormatter.date(from: value)
            return date
        }
        return nil
    }
    
    func getColorValueFrom(representation: AnyObject, for key:String) ->UIColor? {
        if let hexValue = representation[key] as? String{
            var cString:String = hexValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        return nil
    }
}
