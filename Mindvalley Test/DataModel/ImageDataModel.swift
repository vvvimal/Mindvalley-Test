//
//  ImageDataModel.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit


class ImageDataModel:BaseDataModel {
    
    var id: String?
    var createdAt: Date?
    var width: Int?
    var height: Int?
    var color: UIColor?
    var likes: Int?
    var likedByUser:Bool?
    var user:UserDataModel?
    var urls: [String : String]?
    var categories:[CategoryDataModel]?
    var links:[String:String]?

//    override init() {
//        self.id = ""
//        self.createdAt = nil
//        self.width = 0
//        self.height = 0
//        self.color = UIColor.clear
//        self.likes = 0
//        self.likedByUser = false
//        self.user = nil
//        self.urls = [:]
//        self.categories = []
//        self.links = [:]
//        
//    }
    
    init(response: AnyObject) {
        super.init()
        self.id = getStringValueFrom(representation: response, for:"id")
        
        self.createdAt = getDateValueFrom(representation: response, for:"created_at")
        self.width = getIntValueFrom(representation: response, for:"width")
        self.height = getIntValueFrom(representation: response, for:"height")
        self.color = getColorValueFrom(representation: response, for:"color")
        self.likedByUser = response["likedByUser"] as? Bool
        self.likes = getIntValueFrom(representation: response, for: "likes")
        self.user = UserDataModel.init(response: response)
        self.urls = response["urls"] as? Dictionary ?? [:]
        let categoriesValue = response["categories"] as? Array ?? []
        self.categories = []
        for category in categoriesValue{
            let categoryModel = CategoryDataModel.init(response: category as AnyObject)
            self.categories?.append(categoryModel)
        }
        self.links = response["links"] as? Dictionary ?? [:]
    }
    
    var imageUrl: URL? {
        guard let imageURL = urls?["raw"] else {
            return URL(string: "")
        }
        return URL(string: imageURL)
    }
    
}
