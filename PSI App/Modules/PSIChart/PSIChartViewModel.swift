//
//  PSIChartViewModel.swift
//  PSI App
//
//  Created by Gema Megantara on 13/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import SwiftyJSON
import GoogleMaps
import Charts

class PSIChartViewModel {
    
    let apiManager: APIManager = APIManager()
    
    private var psi: PSI!
    private var psiDict = [String: PSIData]()
    private var arrColor:[UIColor] = Helper.sharedInstance.getColorScheme()
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var setDataOnChartClosure: (()->())?
    
    func refreshData(){
        self.initData()
    }
    
    func initData() {
        self.isLoading = true
        
        apiManager.getPSIData(param: "date", value: self.getSGTDateString(), completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let psi):
                print(psi)
                self?.processFetchedData(psi: psi)
            case .failure(let error):
                self?.alertMessage = error?.localizedDescription
            }
        })
    }
    
    private func getSGTDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "SGT")!
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    private func processFetchedData( psi: PSI) {
        self.psi = psi
        for sub in self.psi.regionMetadata {
            let name = sub["name"].rawString()!
            let latitude = sub["label_location"]["latitude"].doubleValue
            let longitude = sub["label_location"]["longitude"].doubleValue
            
            self.psiDict[name] = PSIData(name: name, latitude: latitude, longitude: longitude)
        }
        
        for (key, value) in self.psiDict {
            value.reading.removeAll()
            
            for sub in self.psi.items {
                let psiReading = PSIReading()
                psiReading.o3SubIndex = sub["readings"]["o3_sub_index"][key].doubleValue
                psiReading.pm10TwentyFourHourly = sub["readings"]["pm10_twenty_four_hourly"][key].doubleValue
                psiReading.pm10SubIndex = sub["readings"]["pm10_sub_index"][key].doubleValue
                psiReading.coSubIndex = sub["readings"]["co_sub_index"][key].doubleValue
                psiReading.pm25TwentyFourHourly = sub["readings"]["pm25_twenty_four_hourly"][key].doubleValue
                psiReading.so2_sub_index = sub["readings"]["so2_sub_index"][key].doubleValue
                psiReading.coEightHourMax = sub["readings"]["co_eight_hour_max"][key].doubleValue
                psiReading.no2OneHourMax = sub["readings"]["no2_one_hour_max"][key].doubleValue
                psiReading.so2TwentyFourHourly = sub["readings"]["so2_twenty_four_hourly"][key].doubleValue
                psiReading.pm25SubIndex = sub["readings"]["pm25_sub_index"][key].doubleValue
                psiReading.psiTwentyFourHourly = sub["readings"]["psi_twenty_four_hourly"][key].doubleValue
                psiReading.o3EightHourMax = sub["readings"]["o3_eight_hour_max"][key].doubleValue
                psiReading.timestamp = sub["timestamp"].rawString()
                
                value.reading.append(psiReading)
            }
        }
        
        self.setDataOnChartClosure?()
    }
    
    func getDataAxisForChart() -> [String] {
        var arrString = [String]()
        for (_, value) in self.psiDict {
            
            for sub in value.reading {
                
                let start = sub.timestamp.index(sub.timestamp.startIndex, offsetBy: 11)
                let end = sub.timestamp.index(sub.timestamp.endIndex, offsetBy: -9)
                let range = start..<end
                
                let mySubstring = sub.timestamp[range]
                arrString.append(String(mySubstring))
            }
            break
        }
        
        return arrString
    }
    
    func getDataSetsForChart() -> LineChartData {
        
        var arrayDataSet = [LineChartDataSet]()
        
        var indexColor = 0
        for (key, value) in self.psiDict {
            
            var arrayEntry = [ChartDataEntry]()
            var index = 0
            
            for sub in value.reading {
                let entry = ChartDataEntry(x: Double(index), y: sub.psiTwentyFourHourly)
                arrayEntry.append(entry)
                index += 1
            }
            
            let set = LineChartDataSet(values: arrayEntry, label: "PSI-24h \(key)")
            set.setColor(self.arrColor[indexColor])
            set.setCircleColor(self.arrColor[indexColor])
            set.lineWidth = 2
            set.circleRadius = 4
            set.drawCircleHoleEnabled = false
            set.valueFont = .systemFont(ofSize: 9)
            set.drawValuesEnabled = false
            
            arrayDataSet.append(set)
            indexColor += 1
        }
        
        return LineChartData(dataSets: arrayDataSet)
    }
}

