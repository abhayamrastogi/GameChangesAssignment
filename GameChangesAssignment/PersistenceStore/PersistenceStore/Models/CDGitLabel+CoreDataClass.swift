//
//  CDGitLabel+CoreDataClass.swift
//  PersistenceStore
//
//  Created by Abhayam Rastogi on 14/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import CoreData

@objc(CDGitLabel)
public class CDGitLabel: NSManagedObject, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case nodeID = "node_id"
        case url = "url"
        case name = "name"
        case color = "color"
        
    }
    
    @NSManaged public var id:Int64
    @NSManaged public var nodeID:String?
    @NSManaged public var url:String?
    @NSManaged public var name:String?
    @NSManaged public var color:String?
    
    public class func instanceForData(withJSON json: [String: Any], context: NSManagedObjectContext) ->CDGitLabel? {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve context")
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let user = try decoder.decode(self, from: data)
            
            return user
        }
        catch {
            print("failed to convert data from json in user \(error.localizedDescription) ")
        }
        
        return nil
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "GitLabel", in: managedObjectContext) else {
                fatalError("Failed to decode CDGitLabel")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int64.self, forKey: .id)
            nodeID = try? values.decodeIfPresent(String.self, forKey: .nodeID)
            name = try? values.decodeIfPresent(String.self, forKey: .name)
            color = try? values.decodeIfPresent(String.self, forKey: .color)
            url = try? values.decodeIfPresent(String.self, forKey: .url)
        }
        catch {
            print("values not found in json User while parsing")
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(nodeID, forKey: .nodeID)
            try container.encode(name, forKey: .name)
            try container.encode(color, forKey: .color)
            try container.encode(url, forKey: .url)            
        }catch {
            print("values not founf in json CodingUserInfoKey while parsing")
        }
    }
}
