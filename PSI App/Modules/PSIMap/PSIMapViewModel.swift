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
    
    func initData() {
        self.isLoading = true
        apiManager.getPSIData(completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let psi):
                self?.processFetchedData(psi: psi)
            case .failure(let error):
                self?.alertMessage = error?.localizedDescription
            }
        })
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
            value.o3SubIndex = self.psi.items[0]["readings"]["o3_sub_index"][key].doubleValue
            value.pm10TwentyFourHourly = self.psi.items[0]["readings"]["pm10_twenty_four_hourly"][key].doubleValue
            value.pm10SubIndex = self.psi.items[0]["readings"]["pm10_sub_index"][key].doubleValue
            value.coSubIndex = self.psi.items[0]["readings"]["co_sub_index"][key].doubleValue
            value.pm25TwentyFourHourly = self.psi.items[0]["readings"]["pm25_twenty_four_hourly"][key].doubleValue
            value.so2_sub_index = self.psi.items[0]["readings"]["so2_sub_index"][key].doubleValue
            value.coEightHourMax = self.psi.items[0]["readings"]["co_eight_hour_max"][key].doubleValue
            value.no2OneHourMax = self.psi.items[0]["readings"]["no2_one_hour_max"][key].doubleValue
            value.so2TwentyFourHourly = self.psi.items[0]["readings"]["so2_twenty_four_hourly"][key].doubleValue
            value.pm25SubIndex = self.psi.items[0]["readings"]["pm25_sub_index"][key].doubleValue
            
            value.psiTwentyFourHourly = self.psi.items[0]["readings"]["psi_twenty_four_hourly"][key].doubleValue
            value.o3EightHourMax = self.psi.items[0]["readings"]["o3_eight_hour_max"][key].doubleValue
        }
        
        self.setDataOnMapClosure?()
    }
    
    func getPSIDataObject(loc: String) -> GMSMarker {
        let psiObj = self.psiDict[loc]!
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: psiObj.latitude, longitude: psiObj.longitude)
        marker.title = "Readings"
        var snippetText = "o3_sub_index: \(psiObj.o3SubIndex!)\n"
        snippetText += "pm10_twenty_four_hourly: \(psiObj.pm10TwentyFourHourly!)\n"
        snippetText += "pm10_sub_index: \(psiObj.pm10SubIndex!)\n"
        snippetText += "co_sub_index: \(psiObj.coSubIndex!)\n"
        snippetText += "pm25_twenty_four_hourly: \(psiObj.pm25TwentyFourHourly!)\n"
        snippetText += "so2_sub_index: \(psiObj.so2_sub_index!)\n"
        snippetText += "co_eight_hour_max: \(psiObj.coEightHourMax!)\n"
        snippetText += "no2_one_hour_max: \(psiObj.no2OneHourMax!)\n"
        snippetText += "so2_twenty_four_hourly: \(psiObj.so2TwentyFourHourly!)\n"
        snippetText += "pm25_sub_index: \(psiObj.pm25SubIndex!)\n"
        snippetText += "psi_twenty_four_hourly: \(psiObj.psiTwentyFourHourly!)\n"
        snippetText += "o3_eight_hour_max: \(psiObj.o3EightHourMax!)\n"
        marker.snippet = snippetText
        marker.appearAnimation = GMSMarkerAnimation.pop
        
        return marker
    }
    
    func getPSIInfoWindow(marker: GMSMarker) -> UIView {
        let infoView = UINib(nibName: "InfoWindow", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InfoWindow
        
        infoView.labelContent.text = marker.snippet
        
        return infoView
    }
}
