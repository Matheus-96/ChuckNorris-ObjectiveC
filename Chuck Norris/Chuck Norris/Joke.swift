//
//  Joke.swift
//  Chuck Norris
//
//  Created by Maria Luiza Carvalho Sperotto on 13/11/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import Foundation

struct Joke: Codable {
    var icon_url: String
    var value: String
    
    init(json: [String: Any]) {
        value = json["value"] as? String ?? ""
        icon_url = json["icon_url"] as? String ?? ""
    }
   
}

struct Jokes: Codable {
    let result: [Joke]
}
