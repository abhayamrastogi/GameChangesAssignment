//
//  CDComment+CoreDataClass.swift
//  PersistenceStore
//
//  Created by Abhayam Rastogi on 15/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import CoreData

@objc(CDComment)
public class CDComment: NSManagedObject, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum CodingKeys: String, CodingKey {
        
        case body = "body"
        case user = "user"
        
    }
    
    @NSManaged public var body:String?
    @NSManaged public var user: CDUser?
    
    public class func instanceForData(withJSON json: [String: Any], context: NSManagedObjectContext) ->CDComment? {
        
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
            print("failed to convert data from json in CDComment \(error.localizedDescription) ")
        }
        
        return nil
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Comment", in: managedObjectContext) else {
                fatalError("Failed to decode CDGitLabel")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user = try? values.decodeIfPresent(CDUser.self, forKey: .user)
            body = try? values.decodeIfPresent(String.self, forKey: .body)
        }
        catch {
            print("values not found in json User while parsing")
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(body, forKey: .body)
            try container.encode(user, forKey: .user)
        }catch {
            print("values not founf in json CodingUserInfoKey while parsing")
        }
    }
}
