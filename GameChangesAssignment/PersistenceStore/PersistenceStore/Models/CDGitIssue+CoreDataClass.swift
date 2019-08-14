//
//  CDGitIssue+CoreDataClass.swift
//  PersistenceStore
//
//  Created by Abhayam Rastogi on 14/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import CoreData

@objc(CDGitIssue)
public class CDGitIssue: NSManagedObject, Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    enum CodingKeys: String, CodingKey {
        
        case url = "url"
        case repositoryURL = "repository_url"
        case labelsURL = "labels_url"
        case commentsURL = "comments_url"
        case eventsURL = "events_url"
        case htmlURL = "html_url"
        case id = "id"
        case nodeID = "node_id"
        case number = "number"
        case title = "title"
        case user = "user"
        case labels = "labels"
        case state = "state"
        case locked = "locked"
        case comments = "comments"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case authorAssociation = "author_association"
        case pullRequest = "pull_request"
        case body = "body"
        
    }
    
    @NSManaged public var id:Int64
    @NSManaged public var url: String?
    @NSManaged public var repositoryURL:String?
    @NSManaged public var labelsURL:String?
    @NSManaged public var commentsURL:String?
    @NSManaged public var eventsURL:String?
    @NSManaged public var htmlURL:String?
    @NSManaged public var nodeID:String?
    @NSManaged public var number:Int64
    @NSManaged public var title:String?
    @NSManaged public var state:String?
    @NSManaged public var locked:Bool
    @NSManaged public var comments:Int64
    @NSManaged public var createdAt:String?
    @NSManaged public var updatedAt:String?
    @NSManaged public var authorAssociation:String?
    @NSManaged public var body:String?
    
    public class func instanceForData(withJSON json: [String: Any], context: NSManagedObjectContext) ->CDGitIssue? {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve context")
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let gitIssue = try decoder.decode(self, from: data)
            
            return gitIssue
        }
        catch {
            print("failed to convert data from json in user \(error.localizedDescription) ")
        }
        
        return nil
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "GitIssue", in: managedObjectContext) else {
                fatalError("Failed to decode CDGitIssue")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int64.self, forKey: .id)
            comments = try values.decode(Int64.self, forKey: .comments)
            number = try values.decode(Int64.self, forKey: .number)

            title = try? values.decodeIfPresent(String.self, forKey: .title)

            nodeID = try? values.decodeIfPresent(String.self, forKey: .nodeID)
            url = try? values.decodeIfPresent(String.self, forKey: .url)
            repositoryURL = try? values.decodeIfPresent(String.self, forKey: .repositoryURL)
            createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
            updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
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
            try container.encode(comments, forKey: .comments)
            try container.encode(title, forKey: .title)
            try container.encode(url, forKey: .url)
            try container.encode(repositoryURL, forKey: .repositoryURL)
            try container.encode(createdAt, forKey: .createdAt)
            try container.encode(updatedAt, forKey: .updatedAt)
            try container.encode(number, forKey: .number)

        }catch {
            print("values not founf in json CodingUserInfoKey while parsing")
        }
    }
}
