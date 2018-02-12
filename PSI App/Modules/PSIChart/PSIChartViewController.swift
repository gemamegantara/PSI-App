//
//  PSIChartViewController.swift
//  PSI App
//
//  Created by Gema Megantara on 12/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import UIKit
import Charts
import PKHUD

class PSIChartViewController: UIViewController {

    lazy var viewModel: PSIChartViewModel = {
        return PSIChartViewModel()
    }()
    
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //init chart
        initView()
        
        // init view model
        initVM()
    }
    
    func initView(){
        self.chart.chartDescription?.enabled = false
        self.chart.dragEnabled = true
        self.chart.setScaleEnabled(true)
        self.chart.pinchZoomEnabled = true
        self.chart.legend.form = .line
        self.chart.animate(xAxisDuration: 2.5)
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chart
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.chart.marker = marker
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "SGT")!
        formatter.dateFormat = "MMM d, yyyy"
        let now = formatter.string(from: Date())
        self.labelTitle.text = "24 Hour PSI on \(now)"
    }
    
    func initVM(){
        self.viewModel.setDataOnChartClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.setData()
            }
        }
        
        self.viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        self.viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                if (self?.viewModel.isLoading)!{
                    HUD.show(.progress)
                }else{
                    HUD.hide()
                }
            }
        }
        
        self.viewModel.initData()
    }
    
    func setData(){
        let axisData = self.viewModel.getDataAxisForChart()
        let xAxis = self.chart.xAxis
        
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = false
        xAxis.drawLimitLinesBehindDataEnabled = false
        xAxis.valueFormatter = IntAxisValueFormatter(value: axisData)
        
        self.chart.data = self.viewModel.getDataSetsForChart()
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnRefreshTapped(_ sender: UIBarButtonItem) {
        self.viewModel.refreshData()
        self.chart.notifyDataSetChanged()
        self.chart.resetZoom()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
