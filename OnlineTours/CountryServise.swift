//
//  CountryServise.swift
//  OnlineTours
//
//  Created by Алексей on 01.12.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class CountryService {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }()
    
    func getCity(completion: @escaping ([Country]?) -> Void){
        
        let url = URL (string: "https://www.onlinetours.ru/api/v2/public/depart_cities")!
        
        var request = URLRequest(url: url)
        request.setValue("Token token=4487328fa13e35e6955c1c60d91f6929", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, request, error) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let cities = try jsonDecoder.decode([Country].self, from: data)
                completion(cities)
            } catch (let error) {
                print(error)
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getHotel (completion: @escaping ([Hotel]?) -> Void){
        
        let url = URL (string: "https://run.mocky.io/v3/a21a187f-1bf2-445e-abc5-7c7fe0b22785")!
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, request, error) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            jsonDecoder.dateDecodingStrategy = .formatted(formatter)
            
            do {
                let hotels = try jsonDecoder.decode([Hotel].self, from: data)
                completion(hotels)
            } catch {
                completion(nil)
            }
            
        }
        task.resume()
    }
}

