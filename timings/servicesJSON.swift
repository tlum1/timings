//
//  servicesJSON.swift
//  timings
//
//  Created by Денис Смолянинов on 04.07.2023.
//

import Foundation

class servicesJSON{
    
    func saveToJSON(toFilename filename:String, jsonObject:Any) -> Bool {
        let fm = FileManager.default
                let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
                do {
                    var fileURL = url.appendingPathComponent(filename)
                    fileURL = fileURL.appendingPathExtension("json")
                    let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
                    try data.write(to: fileURL, options: [.atomicWrite])
                    return true
                } catch{
                    print("Error during writing file \(filename).json")
                }
            }
            return false
        }
   

    func loadJSON(withFilename filename: String) -> Any? {
            let fm = FileManager.default
            let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let url = urls.first {
                do{
                    var fileURL = url.appendingPathComponent(filename)
                    fileURL = fileURL.appendingPathExtension("json")
                    let data = try Data(contentsOf: fileURL)
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
//                print(fileURL)
                    return jsonObject
                } catch{
                    print("Error during opening file \(filename).json")
                }
            }
            return nil
        }
}
