//
//  BreakingBadEpisode.swift
//  HandleJSONDecode
//
//  Created by Igor on 02.10.2021.
//

import Foundation

struct RandomUser {
    let results: Results?
    let info: Info?
    
    init(value: [String: Any]) {
        // info
        let info = value["info"] as? [String: Any] ?? [:]
        self.info = Info(value: info)
        
        // results
        /* тут лежит массив словареей, а API только один массив выдает,
         поэтому извлекаем его и делаем единственным в свойстве results */
        let results = value["results"] as? [[String: Any]] ?? [[:]]
        self.results = Results(value: results.first ?? [:])
    }
}

// MARK: - Info

struct Info {
    let seed: String?
    let results: Int?
    let page: Int?
    let version: String?
    
    init(value: [String: Any]) {
        seed = value["seed"] as? String
        results = value["results"] as? Int
        page = value["page"] as? Int
        version = value["version"] as? String
    }
}

// MARK: - Results

struct Results {
    let gender: String?
    let name: Name?
    let location: Location?
    
    init(value: [String: Any]) {
        gender = value["gender"] as? String
        
        // Name init
        let name = value["name"] as? [String: Any] ?? [:]
        self.name = Name(value: name)

        // Location init
        let location = value["location"] as? [String: Any] ?? [:]
        self.location = Location(value: location)
    }
}

// MARK: - Name

struct Name {
    let title: String?
    let first: String?
    let last: String?
    
    init(value: [String: Any]) {
        title = value["title"] as? String
        first = value["first"] as? String
        last = value["last"] as? String
    }
}

// MARK: - Location

struct Location {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postCode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    init(value: [String: Any]) {
        // Street init
        let street = value["street"] as? [String: Any] ?? [:]
        self.street = Street(value: street)
        
        city = value["city"] as? String
        state = value["state"] as? String
        country = value["country"] as? String
        postCode = value["postcode"] as? Int
        
        let coordinates = value["coordinates"] as? [String: Any] ?? [:]
        self.coordinates = Coordinates(value: coordinates)
        
        let timezone = value["timezone"] as? [String: Any] ?? [:]
        self.timezone = Timezone(value: timezone)
    }
}

// MARK: - Street

struct Street {
    let number: Int?
    let name: String?
    
    init(value: [String: Any]) {
        number = value["number"] as? Int
        name = value["name"] as? String
    }
}

// MARK: - Coordinates

struct Coordinates {
    let latitude: String?
    let longitude: String?
    
    init(value: [String: Any]) {
        latitude = value["latitude"] as? String
        longitude = value["longitude"] as? String
    }
}

// MARK: - Timezone

struct Timezone {
    let offset: String?
    let description: String?
    
    init(value: [String: Any]) {
        offset = value["offset"] as? String
        description = value["description"] as? String
    }
}
