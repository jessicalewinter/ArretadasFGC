//
//  FileManager.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class StoreMidia {
    
	static let fileManager = FileManager.default
    
    static func loadImageFromPath(_ path: String) -> UIImage? {
        
        if let dir = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let imagePath = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(path).path
            return UIImage(contentsOfFile: imagePath)
            
        }
        return nil
        
    }
    
    static func saving(image: UIImage, withName: String) -> String {
        
        let directory = "Images"
        var filePath = ""
        if let documentDirectory = try fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentoDiretorio = documentDirectory.appendingPathComponent(directory)
            
            let saida = fileManager.fileExists(atPath: documentoDiretorio.path)
            if !saida {
                do {
                    try fileManager.createDirectory(atPath: documentoDiretorio.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
        }
        if let data = UIImageJPEGRepresentation(image, 1){
            if let path = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL{
                do {
                    filePath = "/\(directory)/\(withName).jpeg"
                    try data.write(to: path.appendingPathComponent(filePath)!)
                    print("Succes in Save Photo!")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return filePath
    }

}
