//
//  Country.swift
//  OnlineTours
//
//  Created by Алексей on 01.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

struct Country: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case countryId = "country_id"
        case countryName = "country_name"
    }
    
    let id: Int
    let name: String
    let countryId: Int?
    let countryName: String?
    
}


