//
//  GitHubEntity.swift
//  Buildasaur
//
//  Created by Honza Dvorsky on 13/12/2014.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

import Foundation

public protocol GitHub {
    init(json: NSDictionary)
}

public class GitHubEntity : GitHub {
    
    public let htmlUrl: String?
    public let url: String?
    public let id: Int?
    
    //initializer which takes a dictionary and fills in values for recognized keys
    public required init(json: NSDictionary) {
        
        self.htmlUrl = json.optionalStringForKey("html_url")
        self.url = json.optionalStringForKey("url")
        self.id = json.optionalIntForKey("id")
    }
    
    public init() {
        self.htmlUrl = nil
        self.url = nil
        self.id = nil
    }
    
    public func dictionarify() -> NSDictionary {
        assertionFailure("Must be overriden by subclasses that wish to dictionarify their data")
        return NSDictionary()
    }
    
    public class func optional<T: GitHubEntity>(json: NSDictionary?) -> T? {
        if let json = json {
            return T(json: json)
        }
        return nil
    }
    
}

//parse an array of dictionaries into an array of parsed entities
public func GitHubArray<T where T:GitHub>(jsonArray: NSArray!) -> [T] {
    
    let array = jsonArray as! [NSDictionary]!
    let parsed = array.map {
        (json: NSDictionary) -> (T) in
        return T(json: json)
    }
    return parsed
}


