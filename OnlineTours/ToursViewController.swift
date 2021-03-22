//
//  ToursViewController.swift
//  OnlineTours
//
//  Created by Алексей on 08.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class ToursViewController: UIViewController {
    
    enum State {
        case data
        case error
        case loading
    }

    var state: State = .loading
    
    var countryService = CountryService()
    var hotelsArray = [Hotel]()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Phone"), style: .plain, target: self, action: nil)
        
       nnnn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
    }
    
    func nnnn() {
        countryService.getHotel { [weak self] hotels in
            if hotels == nil {
                self?.hotelsArray = []
                self?.state = .error
            } else {
                self?.state = .data
                self?.hotelsArray = hotels ?? []
            }
            
            self?.collectionView.reloadData()
            
        }
    }
}

extension ToursViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
            case .data :
                return CGSize(width: 340, height: 385)
            case .error, .loading:
                var size =  view.safeAreaLayoutGuide.layoutFrame.size
                size.height -= 40
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .data :
            return hotelsArray.count
        case .error, .loading:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
            case .data :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! CollectionCell
                
                cell.maxWidth = collectionView.bounds.width - Constants.spacing * 2
                
                let hotel = hotelsArray[indexPath.row]
                cell.configure(hotels: hotel)
                
                return cell
            case .error :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCollerctionCell", for: indexPath) as! ErrorCollectionCell
                cell.delegate = self
                return cell
            case .loading:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionCell", for: indexPath)
                return cell
        }
    }
    
    private enum Constants {
        static let spacing: CGFloat = 16
        static let borderWidth: CGFloat = 0.5
        static let reuseID = "CollectionCell"
    }
}

extension ToursViewController: ErrorCollectionCellDelegate {
    func didTouchTryAgainButton(cell: ErrorCollectionCell) {
        state = .loading
        collectionView.reloadData()
        nnnn()
    }
    
}
