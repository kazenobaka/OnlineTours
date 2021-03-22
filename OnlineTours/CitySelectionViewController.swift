//
//  CitySelectionViewController.swift
//  OnlineTours
//
//  Created by Алексей on 01.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

protocol CitySelectionViewControllerDelegate: class {
    func didSelectedCity(city: Country)
}

class CitySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    weak var delegate: CitySelectionViewControllerDelegate?
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var countryService = CountryService()
    var selectedCityId: Int?
    
    var arrayCities: [Country] = []
    var searchResults: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        countryService.getCity { [weak self] cities in
            self?.arrayCities = cities ?? []
            self?.filterContent(for: "")
            self?.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let city = searchResults[indexPath.row]
        
        if city.id == selectedCityId {
            let image = UIImage(named: "checkmark ")
            if let accessoryView = cell.accessoryView as? UIImageView {
                accessoryView.image = image
            } else {
                cell.accessoryView = UIImageView(image: image)
            }
        } else {
            (cell.accessoryView as? UIImageView)?.image = nil
        }
        
        let name = searchResults[indexPath.row].name
        cell.textLabel?.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCityId = searchResults[indexPath.row].id
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
        
        let city = searchResults[indexPath.row]
        delegate?.didSelectedCity(city: city)
    }
    
    func filterContent(for searchText: String) {
        if searchText.isEmpty {
            searchResults = arrayCities

        } else {
            searchResults = arrayCities.filter({ (city) -> Bool in
                let name = city.name
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContent(for: searchText)
        tableView.reloadData()
    }
    
}
