//
//  Hotel.swift
//  OnlineTours
//
//  Created by Алексей on 14.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

struct Hotel: Codable {
    
    enum CodingKeys: String, CodingKey {
       case id
       case image
       case hotel
       case toDepartureDate = "to_departure_date"
       case fromDepartureDate = "from_departure_date"
       case price
       case priceDescription = "price_description"
    }
    
    let id: Int
    let image: URL
    let hotel: String
    let toDepartureDate: Date
    let fromDepartureDate: Date
    let price: Int
    let priceDescription: String
}
