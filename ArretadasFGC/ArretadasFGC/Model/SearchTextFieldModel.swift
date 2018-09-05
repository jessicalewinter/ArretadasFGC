//
//  SearchTextFieldModel.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import SearchTextField

class SearchTextFieldModel: NSObject {
    
    static func configureSimple(SearchTextField: SearchTextField) {
        // Set data source
        let countries = dataSource()
        SearchTextField.filterStrings(countries)
    }
    
    static func dataSource() -> [String] {
        if let path = Bundle.main.path(forResource: "c", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                
                guard let countries = jsonResult as? [String: [String]] else { return [] }
                
                var cityNames = [String]()
                
                for country in countries {
                    cityNames.append(contentsOf: country.value)
                }

                return cityNames.filter { c -> Bool in
                    return c == "Brazil"
                }
            } catch {
                print("Error parsing jSON: \(error)")
                return []
            }
        }
        return []
    }

}
