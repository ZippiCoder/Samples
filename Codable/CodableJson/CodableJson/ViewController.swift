//
//  ViewController.swift
//  CodableJson
//
//  Created by ZippiCoder on 12/3/17.
//  Copyright © 2017 ZippiCoder. All rights reserved.
//

import UIKit

typealias MesureResult = (title: String, count: Int, averageTime: Double)

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objectsInTest = [50, 100, 500, 1000, 5000, 10000]
        
        DispatchQueue.global(qos: .background).async {
            var csvText = "Type, Count, Time\n"
            
            let testsCount = 10
            
            let decodeResults =   self.mesureSimpleDecode(itemsCount: objectsInTest, testsCount: testsCount)
            for result in decodeResults {
                csvText.append("\(result.title),\(result.count),\(result.averageTime)\n")
            }
            
            
            let decodeComplexResults = self.mesureComplexDecode(itemsCount: objectsInTest, testsCount: testsCount)
            for result in decodeComplexResults {
                csvText.append("\(result.title),\(result.count),\(result.averageTime)\n")
            }
            
            DispatchQueue.main.async {
                let fileName = "Tasks.csv"
                if let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) {
                    print(path)
                    do {
                        try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("Failed to create file")
                        print("\(error)")
                    }
                    
                    let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func mesureSimpleDecode(itemsCount: [Int], testsCount: Int) -> [MesureResult] {
        var result: [MesureResult]  = []
        let dataProvider = MockDataProvider()
        
        for items in itemsCount {
            var totalCodableTime: Double = 0
            var totalManualTime: Double = 0
            
            for _ in 1...testsCount {
                autoreleasepool {
                    
                    if let jsonData = dataProvider.createJson(items: items), let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]] {
                        
                        // decode with JSONDecoder
                        let codabletime = measure("Writer Codable", block: {
                            _ = try? JSONDecoder().decode([Writer].self, from: jsonData)
                        })
                        totalCodableTime += codabletime
                        
                        // manual decoding
                        let manualTime = measure("Writer Manual", block: {
                            _ = jsonArray.map({ Writer(dictionary: $0)})
                        })
                        
                        totalManualTime += manualTime
                        
                    }
                }
            }
            
            result.append(MesureResult(title: "Writer Codable", count: items, averageTime: totalCodableTime/Double(testsCount)))
            result.append(MesureResult(title: "Writer Manual", count: items, averageTime: totalManualTime/Double(testsCount)))
        }
        
        return result
    }
    
    func mesureComplexDecode(itemsCount: [Int], testsCount: Int) -> [MesureResult] {
        var result: [MesureResult]  = []
        let dataProvider = MockDataProvider()
        
        for items in itemsCount {
            var totalCodableTime: Double = 0
            var totalManualTime: Double = 0
            
            for _ in 1...testsCount {
                autoreleasepool {
                    
                    if let jsonData = dataProvider.createComplexJson(items: items), let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]] {
                        
                        // decode with JSONDecoder
                        let codabletime = measure("Complex Writer Codable", block: {
                            _ = try? JSONDecoder().decode([ComplexWriter].self, from: jsonData)
                        })
                        totalCodableTime += codabletime
                        
                        // manual decoding
                        let manualTime = measure("Complex Writer Manual", block: {
                            _ = jsonArray.map({ ComplexWriter(dictionary: $0)})
                        })
                        
                        totalManualTime += manualTime
                        
                    }
                }
            }
            
            result.append(MesureResult(title: "Complex Writer Codable", count: items, averageTime: totalCodableTime/Double(testsCount)))
            result.append(MesureResult(title: "Complex Writer Manual", count: items, averageTime: totalManualTime/Double(testsCount)))
        }
        
        return result
        
    }
    
    // MARK: - Measure
    func measure(_ title: String, block: () -> ()) -> CFAbsoluteTime {
        let startTime = CFAbsoluteTimeGetCurrent()
        block()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return timeElapsed
    }
}

