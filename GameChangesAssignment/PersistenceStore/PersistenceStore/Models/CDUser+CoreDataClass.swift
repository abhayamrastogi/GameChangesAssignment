//
//  CDUser+CoreDataClass.swift
//  PersistenceStore
//
//  Created by Abhayam Rastogi on 14/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import CoreData

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}


@objc(CDUser)
public class CDUser: NSManagedObject, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum CodingKeys: String, CodingKey {
        
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url = "url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
        case followingURL = "following_url"
        
    }
    
    @NSManaged public var login: String?
    @NSManaged public var id: String?
    @NSManaged public var nodeId: String?
    @NSManaged public var avatarURL: String?
    @NSManaged public var gravatarID: String?
    @NSManaged public var url: String?
    @NSManaged public var htmlURL: String?
    @NSManaged public var followersURL:String?
    @NSManaged public var followingURL:String?
    @NSManaged public var gistsURL: String?
    @NSManaged public var starredURL:String?
    @NSManaged public var subscriptionsURL:String?
    @NSManaged public var organizationsURL:String?
    @NSManaged public var reposURL:String?
    @NSManaged public var eventsURL:String?
    @NSManaged public var receivedEventsURL:String?
    @NSManaged public var type:String?
    @NSManaged public var siteAdmin:Bool
    
    public class func instanceForData(withJSON json: [String: Any], context: NSManagedObjectContext) ->CDUser? {
        
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
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            login = try? values.decodeIfPresent(String.self, forKey: .login)
            id = try? values.decodeIfPresent(String.self, forKey: .id)
            nodeId = try? values.decodeIfPresent(String.self, forKey: .nodeId)
            avatarURL = try? values.decodeIfPresent(String.self, forKey: .avatarURL)
            gravatarID = try? values.decodeIfPresent(String.self, forKey: .gravatarID)
            url = try? values.decodeIfPresent(String.self, forKey: .url)
            htmlURL = try? values.decodeIfPresent(String.self, forKey: .htmlURL)
            followersURL = try? values.decodeIfPresent(String.self, forKey: .followersURL)
            followingURL = try? values.decodeIfPresent(String.self, forKey: .followingURL)
            gistsURL = try? values.decodeIfPresent(String.self, forKey: .gistsURL)
            starredURL = try? values.decodeIfPresent(String.self, forKey: .starredURL)
            subscriptionsURL = try? values.decodeIfPresent(String.self, forKey: .subscriptionsURL)
            organizationsURL = try? values.decodeIfPresent(String.self, forKey: .organizationsURL)
            reposURL = try? values.decodeIfPresent(String.self, forKey: .reposURL)
            eventsURL = try? values.decodeIfPresent(String.self, forKey: .eventsURL)
            type = try? values.decodeIfPresent(String.self, forKey: .type)
            receivedEventsURL = try? values.decodeIfPresent(String.self, forKey: .receivedEventsURL)
            siteAdmin = try values.decode(Bool.self, forKey: .siteAdmin)
        }
        catch {
            print("values not found in json User while parsing")
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(login, forKey: .login)
            try container.encode(id, forKey: .id)
            try container.encode(nodeId, forKey: .nodeId)
            try container.encode(avatarURL, forKey: .avatarURL)
            try container.encode(gravatarID, forKey: .gravatarID)
            try container.encode(url, forKey: .url)
            try container.encode(htmlURL, forKey: .htmlURL)
            try container.encode(followersURL, forKey: .followersURL)
            try container.encode(followingURL, forKey: .followingURL)
            try container.encode(gistsURL, forKey: .gistsURL)
            try container.encode(starredURL, forKey: .starredURL)
            try container.encode(subscriptionsURL, forKey: .subscriptionsURL)
            try container.encode(organizationsURL, forKey: .organizationsURL)
            try container.encode(type, forKey: .type)
            try container.encode(reposURL, forKey: .reposURL)
            try container.encode(eventsURL, forKey: .eventsURL)
            try container.encode(receivedEventsURL, forKey: .receivedEventsURL)
            try container.encode(siteAdmin, forKey: .siteAdmin)

        }catch {
            print("values not founf in json CodingUserInfoKey while parsing")
        }
    }
}
