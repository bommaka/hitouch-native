//
//  Deals.swift
//  Hi-Touch
//
//  Created by Swathi B on 10/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import Foundation

class Deals {
    public var _id : String?
    public var updatedAt : String?
    public var createdAt : String?
    public var user : String?
    public var name : String?
    public var __v : Int?
    public var bundle : Bundle?
    public var is_downloaded : Bool?
    public var date : String?
    public var time : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        _id = dictionary["_id"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        createdAt = dictionary["createdAt"] as? String
        user = dictionary["user"] as? String
        name = dictionary["name"] as? String
        __v = dictionary["__v"] as? Int
        if let bundleDic = dictionary["bundle"] as? [String: AnyObject] {
            bundle = Bundle(dictionary: bundleDic)
        }
        is_downloaded = dictionary["is_downloaded"] as? Bool
        date = dictionary["date"] as? String
        time = dictionary["time"] as? String
    }
}

public class Bundle {
    public var _id : String?
    public var updatedAt : String?
    public var createdAt : String?
    public var cover : String?
    public var name : String?
    public var __v : Int?
    public var title_data : Array<String>?
    public var titles : Array<String>?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        _id = dictionary["_id"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        createdAt = dictionary["createdAt"] as? String
        cover = dictionary["cover"] as? String
        name = dictionary["name"] as? String
        __v = dictionary["__v"] as? Int
//        if (dictionary["title_data"] != nil) { title_data = title_data.modelsFromDictionaryArray(dictionary["title_data"] as! NSArray) }
//        if (dictionary["titles"] != nil) { titles = titles.modelsFromDictionaryArray(dictionary["titles"] as! NSArray) }
    }
}
