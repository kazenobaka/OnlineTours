//
//  CollectionCell.swift
//  OnlineTours
//
//  Created by Алексей on 08.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var hotel: UILabel!
    @IBOutlet var toDepartureDate: UILabel!
    @IBOutlet var fromDepartureDate: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var priceDescription: UILabel!
    
    
    func configure(hotels: Hotel) {
        photo.kf.setImage(with: hotels.image)
        
        hotel.text = hotels.hotel
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM E"
        
        toDepartureDate.text = dateFormatter.string(from: hotels.toDepartureDate)
        fromDepartureDate.text = dateFormatter.string(from: hotels.fromDepartureDate)
        
        price.text = "\(hotels.price)"
        priceDescription.text = hotels.priceDescription
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 15.0
        self.layer.cornerRadius = 24.0
        
    }
    
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
}
