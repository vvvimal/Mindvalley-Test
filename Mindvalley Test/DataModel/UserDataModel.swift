//
//  UserDataModel.swift
//  Mindvalley Test
//
//  Created by Venugopalan, Vimal on 12/2/18.
//  Copyright © 2018 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class UserDataModel: BaseDataModel {
    var id: String?
    var username: String?
    var name: String?
    var profileImage:[String:String]?
    var links:[String:String]?
    
//    override init() {
//        self.id = ""
//        self.username = ""
//        self.name = ""
//        self.profileImage = [:]
//        self.links = [:]
//        
//    }
    init(response: AnyObject) {
        super.init()
        self.id = getStringValueFrom(representation: response, for: "id")
        self.username = getStringValueFrom(representation: response, for: "username")
        self.name = getStringValueFrom(representation: response, for: "name")
        self.profileImage = response["profile_image"] as? Dictionary ?? [:]
        self.links = response["links"] as? Dictionary ?? [:]
    }
}
