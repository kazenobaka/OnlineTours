//
//  ErrorCollectionCell.swift
//  OnlineTours
//
//  Created by Алексей on 15.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

protocol  ErrorCollectionCellDelegate: class {
    
    func didTouchTryAgainButton(cell: ErrorCollectionCell)
    
}

class ErrorCollectionCell: UICollectionViewCell {
     
    weak var delegate: ErrorCollectionCellDelegate?
    
    @IBAction func didTouchTryAgain(sender: UIButton) {
        delegate?.didTouchTryAgainButton(cell: self)
    }
    
}
