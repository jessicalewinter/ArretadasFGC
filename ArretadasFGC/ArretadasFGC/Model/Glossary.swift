//
//  Glossary.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation


class Glossary {
    var dictionary : NSDictionary?
    
    init(dict: NSDictionary) {
        dictionary = dict
    }
    
    convenience init() {
        self.init(dict: [:])
        self.dictionary = readPlist()
    }
    
    //Read data from Plist file
    func  readPlist(named path: String = "GlossaryData", bundle: Bundle = Bundle.main) -> NSDictionary? {
        if let path = bundle.path(forResource: path, ofType: "plist"),
            let glossaryDict = NSDictionary(contentsOfFile: path){
            return glossaryDict
        } else {
            return nil
        }
    }
}
