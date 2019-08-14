//
//  APIResource.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public enum Type: Int {
    case number
    case string
    case bool
    case array
    case dictionary
    case null
    case unknown
}

open class APIResource {
    
    public fileprivate(set) var type: Type = .null

    public var raw: Any {
        get {
            switch self.type {
            case .array:
                return self.rawArray
            case .dictionary:
                return self.rawDictionary
            case .string:
                return self.rawString
            case .number:
                return self.rawNumber
            case .bool:
                return self.rawBool
            default:
                return self.rawNull
            }
        }
        set {
            switch unwrap(newValue) {
           case let string as String:
                type = .string
                self.rawString = string
            case _ as NSNull:
                type = .null
            case nil:
                type = .null
            case let array as [Any]:
                type = .array
                self.rawArray = array
            case let dictionary as [String: Any]:
                type = .dictionary
                self.rawDictionary = dictionary
            default:
                type = .unknown
            }
        }
    }
    
    fileprivate var rawArray: [Any] = []
    fileprivate var rawDictionary: [String: Any] = [:]
    fileprivate var rawString: String = ""
    fileprivate var rawNumber: NSNumber = 0
    fileprivate var rawNull: NSNull = NSNull()
    fileprivate var rawBool: Bool = false

    required public init(_ raw: Any) {
        self.raw = raw
    }
    
    private func unwrap(_ object: Any) -> Any {
        switch object {
        case let array as [Any]:
            return array.map(unwrap)
        case let dictionary as [String: Any]:
            var unwrappedDic = dictionary
            for (k, v) in dictionary {
                unwrappedDic[k] = unwrap(v)
            }
            return unwrappedDic
        default:
            return object
        }
    }
}

public extension APIResource {
    
    public var array: [[String: Any]]? {
        if self.type == .array {
            return self.rawArray.map { APIResource($0).rawDictionary }
        } else {
            return nil
        }
    }
}
