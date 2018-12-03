//
//  CategoryDataModel.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class CategoryDataModel:BaseDataModel {
    var id: String?
    var title: String?
    var photoCount: Int?
    var links:[String:String]?
    
//    override init() {
//        self.id = ""
//        self.title = ""
//        self.photoCount = 0
//        self.links = [:]
//        
//    }
    init(response: AnyObject) {
        super.init()
        self.id = getStringValueFrom(representation: response, for: "id")
        self.title = getStringValueFrom(representation: response, for: "title")
        self.photoCount = getIntValueFrom(representation: response, for: "photoCount")
        self.links = response["links"] as? Dictionary ?? [:]
    }
}
