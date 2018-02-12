//
//  ViewController.swift
//  PSI App
//
//  Created by Gema Megantara on 10/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import UIKit
import GoogleMaps

class PSIMapViewController: UIViewController {
    
    var mapView: GMSMapView!
    lazy var viewModel: PSIMapViewModel = {
        return PSIMapViewModel()
    }()
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init map
        initView()
        
        // init view model
        initVM()
    }
    
    func initView(){
        let camera = GMSCameraPosition.camera(withLatitude: 1.35735, longitude: 103.82, zoom: 10.4)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = self.mapView
        self.mapView.delegate = self
    }
    
    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {

            }
        }
        
        viewModel.setDataOnMapClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.initMarker()
            }
        }
        
        viewModel.initData()
        
    }
    
    func initMarker(){
        for pos in viewModel.getPSIDataPosition(){
            let marker = viewModel.getPSIDataObject(loc: pos)
            marker.map = self.mapView
        }
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - GMSMapViewDelegates
extension PSIMapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return viewModel.getPSIInfoWindow(marker: marker)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.mapView.selectedMarker = nil
    }
}
