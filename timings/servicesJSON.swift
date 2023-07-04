//
//  servicesJSON.swift
//  timings
//
//  Created by Денис Смолянинов on 04.07.2023.
//

import Foundation

class servicesJSON{
    func saveToJSON(fileName:String, data:String) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(fileName)
            print("\(pathWithFilename)")
            do {
                try data.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
            } catch {
                print("error")
            }
        }
    }
    
    func readJSON(fileName:String)-> Dictionary<String, Dictionary<String, Dictionary<String, String>>>{
        var result: Dictionary<String, Dictionary<String, Dictionary<String, String>>> = [:]
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as?  Dictionary<String, Dictionary<String, Dictionary<String, String>>>{
                    result = jsonResult
                }
              } catch {
                   print("Error during opening file \(fileName).json")
              }
        }
        
        return result
    }
}
