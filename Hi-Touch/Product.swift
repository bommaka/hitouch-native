//
//  Product.swift
//  Hi-Touch
//
//  Created by Swathi B on 14/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import Foundation

class Product {
    public var formats : [Formats]?
    public var subjectGroup : String?
    public var imprint : String?
    public var datePublication : String?
    public var edition : Int?
    public var description : String?
    public var title : String?
    public var originators : [Originators]?
    public var dacKey : String?
    public var classifications : [String]?
    public var pages : Int?
    public var firstPublishedOn : String?
    public var subtitle : String?
    public var categories : [Categories]?
    public var es_doc_type : String?
    public var es_score : Int?


    required public init?(dictionary: [String:AnyObject]) {
        if let formatsDic = dictionary["formats"] as? [[String: AnyObject]] {
            let array = formatsDic.map({ (dict) -> Formats in
                let formats = Formats(dictionary: dict)
                return formats!
            })
            self.formats = array
        }
        subjectGroup = dictionary["subjectGroup"] as? String
        imprint = dictionary["imprint"] as? String
        datePublication = dictionary["datePublication"] as? String
        edition = dictionary["edition"] as? Int
        description = dictionary["description"] as? String
        title = dictionary["title"] as? String
        if let originatorsDic = dictionary["originators"] as? [[String: AnyObject]] {
            let array = originatorsDic.map({ (dict) -> Originators in
                let originator = Originators(dictionary: dict)
                return originator!
            })
            self.originators = array
        }
        dacKey = dictionary["dacKey"] as? String
        
//        if (dictionary["classifications"] != nil) { classifications = Classifications.modelsFromDictionaryArray(dictionary["classifications"] as! NSArray) }
        pages = dictionary["pages"] as? Int
        firstPublishedOn = dictionary["firstPublishedOn"] as? String
        subtitle = dictionary["subtitle"] as? String
        if let categoriesDic = dictionary["categories"] as? [[String: AnyObject]] {
            let array = categoriesDic.map({ (dict) -> Categories in
                let categorie = Categories(dictionary: dict)
                return categorie!
            })
            self.categories = array
        }
        es_doc_type = dictionary["es_doc_type"] as? String
        es_score = dictionary["es_score"] as? Int
    }
}

public class Formats {
    public var versionType : String?
    public var bindingStyle : String?
    public var versionTypeCode : String?
    public var datePublication : String?
    public var isbnMobi : String?
    public var isbn13 : Int?
    public var licensedEntities : [String]?
    public var bindingStyleCode : String?
    public var isbnEpub : String?
    public var status : String?
    public var statusCode : String?
    public var isbnPdf : String?
    public var coverImages : [String]?
    
    required public init?(dictionary: [String:AnyObject]) {
        versionType = dictionary["versionType"] as? String
        bindingStyle = dictionary["bindingStyle"] as? String
        versionTypeCode = dictionary["versionTypeCode"] as? String
        datePublication = dictionary["datePublication"] as? String
        isbnMobi = dictionary["isbnMobi"] as? String
        isbn13 = dictionary["isbn13"] as? Int
//        if (dictionary["licensedEntities"] != nil) { licensedEntities = LicensedEntities.modelsFromDictionaryArray(dictionary["licensedEntities"] as! NSArray) }
        bindingStyleCode = dictionary["bindingStyleCode"] as? String
        isbnEpub = dictionary["isbnEpub"] as? String
        status = dictionary["status"] as? String
        statusCode = dictionary["statusCode"] as? String
        isbnPdf = dictionary["isbnPdf"] as? String
//        if (dictionary["coverImages"] != nil) { coverImages = CoverImages.modelsFromDictionaryArray(dictionary["coverImages"] as! NSArray) }
    }
}

public class Categories {
    public var code : String?
    public var level : Int?
    public var __v : Int?
    public var _id : String?
    public var text : String?
    public var dataSource : String?
    public var updatedAt : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        code = dictionary["code"] as? String
        level = dictionary["level"] as? Int
        __v = dictionary["__v"] as? Int
        _id = dictionary["_id"] as? String
        text = dictionary["text"] as? String
        dataSource = dictionary["dataSource"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
}

public class Originators {
    public var _id : String?
    public var type : Type?
    public var originators : [NameOriginators]?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        _id = dictionary["_id"] as? String
        if let typeDic = dictionary["type"] as? [String:AnyObject] { type = Type(dictionary: typeDic) }
        
        if let originatorsDic = dictionary["originators"] as? [[String: AnyObject]] {
            let array = originatorsDic.map({ (dict) -> NameOriginators in
                let formats = NameOriginators(dictionary: dict)
                return formats!
            })
            self.originators = array
        }
    }
}

public class NameOriginators {
    public var role : Role?
    public var credentials : String?
    public var idExternal : String?
    public var bio : String?
    public var sort : Int?
    public var idLocation : Int?
    public var affiliation : String?
    public var __v : Int?
    public var name : Name?
    public var _id : String?
    public var salutation : String?
    public var id : String?
    public var dataSource : String?
    public var updatedAt : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        if let roleDic = dictionary["role"] as? [String:AnyObject] { role = Role(dictionary: roleDic) }
        credentials = dictionary["credentials"] as? String
        idExternal = dictionary["idExternal"] as? String
        bio = dictionary["bio"] as? String
        sort = dictionary["sort"] as? Int
        idLocation = dictionary["idLocation"] as? Int
        affiliation = dictionary["affiliation"] as? String
        __v = dictionary["__v"] as? Int
        if let nameDic = dictionary["name"] as? [String:AnyObject] { name = Name(dictionary: nameDic) }
        _id = dictionary["_id"] as? String
        salutation = dictionary["salutation"] as? String
        id = dictionary["id"] as? String
        dataSource = dictionary["dataSource"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }

}

public class Type {
    public var code : String?
    public var prefix : String?
    public var sortOrder : Int?
    public var _id : String?
    public var text : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        code = dictionary["code"] as? String
        prefix = dictionary["prefix"] as? String
        sortOrder = dictionary["sortOrder"] as? Int
        _id = dictionary["_id"] as? String
        text = dictionary["text"] as? String
    }

}

public class Name {
    public var last : String?
    public var id : String?
    public var first : String?
    public var full : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        last = dictionary["last"] as? String
        id = dictionary["id"] as? String
        first = dictionary["first"] as? String
        full = dictionary["full"] as? String
    }
}

public class Role {
    public var code : String?
    public var text : String?
    public var id : String?
    
    required public init?(dictionary: [String:AnyObject]) {
        
        code = dictionary["code"] as? String
        text = dictionary["text"] as? String
        id = dictionary["id"] as? String
    }
}
