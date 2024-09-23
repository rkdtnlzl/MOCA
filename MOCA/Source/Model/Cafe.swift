//
//  Cafe.swift
//  MOCA
//
//  Created by 강석호 on 9/18/24.
//

import Foundation

struct Cafe: Identifiable, Codable {
    let id = UUID()
    let placeName: String
    let addressName: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
    }
}

struct CafeResponse: Codable {
    let documents: [Cafe]
}
