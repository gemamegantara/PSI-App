//
//  PSIChartViewController.swift
//  PSI App
//
//  Created by Gema Megantara on 12/02/18.
//  Copyright © 2018 Gema Megantara. All rights reserved.
//

import UIKit
import Charts

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
        chart.chartDescription?.enabled = false
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = true
        chart.legend.form = .line
        chart.animate(xAxisDuration: 2.5)
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chart
        marker.minimumSize = CGSize(width: 80, height: 40)
        chart.marker = marker
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "SGT")!
        formatter.dateFormat = "MMM d, yyyy"
        let now = formatter.string(from: Date())
        self.labelTitle.text = "24 Hour PSI on \(now)"
    }
    
    func initVM(){
        viewModel.setDataOnChartClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.setData()
            }
        }
        
        viewModel.initData()
    }
    
    func setData(){
        chart.data = viewModel.getDataSetsForChart()
        
        let axisData = viewModel.getDataAxisForChart()
        
        let xAxis = chart.xAxis

        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = false
        xAxis.drawLimitLinesBehindDataEnabled = false
        xAxis.valueFormatter = IntAxisValueFormatter(value: axisData)
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
