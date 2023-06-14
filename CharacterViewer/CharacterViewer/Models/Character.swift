//
//  Character.swift
//  CharacterViewer
//
//  Created by Pradeep on 6/13/23.
//

import Foundation

struct Character: Decodable {
    let heading: String
    let topics: [RelatedTopic]
    
    enum CodingKeys: String, CodingKey {
        case heading = "Heading"
        case topics = "RelatedTopics"
    }
}

struct RelatedTopic: Decodable {
    let mainURL: String
    let details: String
    let icon: IconDetails
    
    enum CodingKeys: String, CodingKey {
        case mainURL = "FirstURL"
        case details = "Text"
        case icon = "Icon"
    }
    
    var name: String {
        return details.components(separatedBy: " -").first ?? ""
    }
    
    var iconURL: String {
        if !icon.urlExtension.isEmpty {
            return "https://duckduckgo.com" + icon.urlExtension
        } else {
            return ""
        }
    }
}

struct IconDetails: Decodable {
    let height: String
    let urlExtension: String
    let width: String
    
    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case urlExtension = "URL"
        case width = "Width"
    }
}
