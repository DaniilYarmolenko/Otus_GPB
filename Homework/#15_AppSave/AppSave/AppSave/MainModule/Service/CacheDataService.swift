//
//  CacheDataService.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 03.12.2022.
//

import Foundation

final class CacheDataService: ServiceCacheDataInput {
    static let shared = CacheDataService()
    
    func isContain(with name: String) -> Bool {
        guard (try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent("AppSave/\(name)")) != nil else {return true}
        return false
    }
    
    func delete(with id: String) {
        guard let fileCachePath = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent("AppSave/\(id).json") else { return }
        try? FileManager.default.removeItem(at: fileCachePath)
        var urlsArray = UserDefaults.standard.stringArray(forKey: "urls")
        var names = UserDefaults.standard.stringArray(forKey: "nameCache")
        let indexName = names?.firstIndex(of: id)
        let index = urlsArray?.firstIndex(of: "\(fileCachePath)")
        if let index = index, let indexName = indexName{
            urlsArray?.remove(at: index)
            names?.remove(at: indexName)
        }
        
        UserDefaults.standard.set(urlsArray, forKey: "urls")
        UserDefaults.standard.set(names, forKey: "nameCache")
    }
    
    func insert(with model: ImageSaveModel) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        print("doc URL \(docURL)")
        let dataPath = docURL.appendingPathComponent("AppSave")
        print("dataPath \(dataPath)")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        guard let filePath = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true).appendingPathComponent("AppSave/\(model.name).json") else { return }
        
        do {
            let data = try JSONEncoder().encode(model)
            try data.write(to: filePath)
        } catch let e {
            print("ERROR insert: \(e)")
        }
        var urlsArray = UserDefaults.standard.stringArray(forKey: "urls")
        var names = UserDefaults.standard.stringArray(forKey: "nameCache")
        if urlsArray != nil && names != nil {
            urlsArray!.append("\(filePath)")
            names!.append(model.name)
        } else {
            urlsArray = ["\(filePath)"]
            names = [model.name]
        }
        UserDefaults.standard.set(urlsArray, forKey: "urls")
        UserDefaults.standard.set(names, forKey: "nameCache")
        
    }
    
    func fetchAll() -> [ImageSaveModel] {
        let urls = UserDefaults.standard.stringArray(forKey: "urls")
        var arrayResult: [ImageSaveModel] = []
        do {
            try urls?.forEach{ url in
                if let urlRequest = URL(string: url) {
                    let jsondata = try Data(contentsOf: urlRequest)
                    let data = try JSONDecoder().decode(ImageSaveModel.self, from: jsondata)
                    arrayResult.append(data)
                }
            }
        } catch let e {
                        print("ERROR: \(e)")
        }
        return arrayResult
    }
    
    func deleteAll() {
        guard let fileCachePath = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent("AppSave") else { return }
        try? FileManager.default.removeItem(at: fileCachePath)
        var urlsArray = UserDefaults.standard.stringArray(forKey: "urls")
        var names = UserDefaults.standard.stringArray(forKey: "nameCache")
        urlsArray = []
        names = []
        UserDefaults.standard.set(urlsArray, forKey: "urls")
        UserDefaults.standard.set(names, forKey: "nameCache")
    }
    
}

