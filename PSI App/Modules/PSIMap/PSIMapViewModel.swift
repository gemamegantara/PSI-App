//
//  PSIMapViewModel.swift
//  PSI App
//
//  Created by Gema Megantara on 11/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import Foundation
import SwiftyJSON
import GoogleMaps

class PSIMapViewModel {
    
    let apiManager: APIManager = APIManager()
    
    private var psi: PSI!
    private var psiDict = [String: PSIData]()
    
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
    var setDataOnMapClosure: (()->())?
    
    func refreshData(){
        self.initData()
    }
    
    func initData() {
        self.isLoading = true
        
        apiManager.getPSIData(param: "date_time", value: self.getSGTDateTimeString(), completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let psi):
                self?.processFetchedData(psi: psi)
            case .failure(let error):
                self?.alertMessage = error?.localizedDescription
            }
        })
    }
    
    private func getSGTDateTimeString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "SGT")!
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
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
            
            let psiReading = PSIReading()
            psiReading.o3SubIndex = self.psi.items[0]["readings"]["o3_sub_index"][key].doubleValue
            psiReading.pm10TwentyFourHourly = self.psi.items[0]["readings"]["pm10_twenty_four_hourly"][key].doubleValue
            psiReading.pm10SubIndex = self.psi.items[0]["readings"]["pm10_sub_index"][key].doubleValue
            psiReading.coSubIndex = self.psi.items[0]["readings"]["co_sub_index"][key].doubleValue
            psiReading.pm25TwentyFourHourly = self.psi.items[0]["readings"]["pm25_twenty_four_hourly"][key].doubleValue
            psiReading.so2_sub_index = self.psi.items[0]["readings"]["so2_sub_index"][key].doubleValue
            psiReading.coEightHourMax = self.psi.items[0]["readings"]["co_eight_hour_max"][key].doubleValue
            psiReading.no2OneHourMax = self.psi.items[0]["readings"]["no2_one_hour_max"][key].doubleValue
            psiReading.so2TwentyFourHourly = self.psi.items[0]["readings"]["so2_twenty_four_hourly"][key].doubleValue
            psiReading.pm25SubIndex = self.psi.items[0]["readings"]["pm25_sub_index"][key].doubleValue
            
            psiReading.psiTwentyFourHourly = self.psi.items[0]["readings"]["psi_twenty_four_hourly"][key].doubleValue
            psiReading.o3EightHourMax = self.psi.items[0]["readings"]["o3_eight_hour_max"][key].doubleValue
            psiReading.timestamp = self.psi.items[0]["timestamp"].rawString()
            
            value.reading.append(psiReading)
        }
        
        self.setDataOnMapClosure?()
    }
    
    //getting key of the direction
    func getPSIDataPosition() -> [String] {
        var position = [String]()
        for (key, _) in self.psiDict {
            position.append(key)
        }
        
        return position
    }
    
    //create marker
    func getPSIDataObject(loc: String) -> GMSMarker {
        let psiObj = self.psiDict[loc]!
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: psiObj.latitude, longitude: psiObj.longitude)
        marker.title = "\(psiObj.name) PSI readings:"
        var snippetText = "o3_sub_index: \(psiObj.reading[0].o3SubIndex!)\n"
        snippetText += "pm10_twenty_four_hourly: \(psiObj.reading[0].pm10TwentyFourHourly!)\n"
        snippetText += "pm10_sub_index: \(psiObj.reading[0].pm10SubIndex!)\n"
        snippetText += "co_sub_index: \(psiObj.reading[0].coSubIndex!)\n"
        snippetText += "pm25_twenty_four_hourly: \(psiObj.reading[0].pm25TwentyFourHourly!)\n"
        snippetText += "so2_sub_index: \(psiObj.reading[0].so2_sub_index!)\n"
        snippetText += "co_eight_hour_max: \(psiObj.reading[0].coEightHourMax!)\n"
        snippetText += "no2_one_hour_max: \(psiObj.reading[0].no2OneHourMax!)\n"
        snippetText += "so2_twenty_four_hourly: \(psiObj.reading[0].so2TwentyFourHourly!)\n"
        snippetText += "pm25_sub_index: \(psiObj.reading[0].pm25SubIndex!)\n"
        snippetText += "psi_twenty_four_hourly: \(psiObj.reading[0].psiTwentyFourHourly!)\n"
        snippetText += "o3_eight_hour_max: \(psiObj.reading[0].o3EightHourMax!)\n"
        marker.snippet = snippetText
        marker.appearAnimation = GMSMarkerAnimation.pop
        
        return marker
    }
    
    //create custom info window
    func getPSIInfoWindow(marker: GMSMarker) -> UIView {
        let infoView = UINib(nibName: "InfoWindow", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InfoWindow
        
        infoView.labelTitle.text = marker.title
        infoView.labelContent.text = marker.snippet
        
        return infoView
    }
}
