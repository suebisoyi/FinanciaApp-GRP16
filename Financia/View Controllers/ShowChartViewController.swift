

//  ShowChartViewController.swift
//  Financia
//
//  Created by  on 4/17/21.
//

import UIKit
import Charts

class ShowChartViewController: UIViewController, ChartViewDelegate {
    
    private var viewModel = StatementViewModel()
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pieView: PieChartView!
    let statementCat = ["Expenses", "Income"]
    var statementValues : [Int] = []
    var barChartLabels : [String] = []
    var barChartValues : [Int] = []
    @IBOutlet weak var lineChart: BarChartView!

    override func viewDidLoad() {
      super.viewDidLoad()
        pieView.legend.font = UIFont.systemFont(ofSize: 15.0)
        loadData()
        let incomeExpense = mainDelegate.sumExpensesIncome()
        barChartLabels = mainDelegate.getExpensesNames() ?? [""]
        barChartValues = mainDelegate.getExpenses() ?? [0]
        statementValues = incomeExpense
        customizeChart(dataPoints: statementCat, values: statementValues.map{ Double($0) })
        lineChart.delegate = self
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //view.addSubview(lineChart)
        
        var entries = [BarChartDataEntry]()
                
        for x in 0..<barChartValues.count {
            var barchentry = BarChartDataEntry(x: Double(x), y: Double(barChartValues[x]))
            entries.append(barchentry)
        }
    
        let set = BarChartDataSet(entries: entries, label: "Top 3 expenses from largest to smallest")
        set.colors = ChartColorTemplates.material()
        
        let data = BarChartData(dataSet: set)
        data.barWidth = 0.2
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: barChartLabels)
        lineChart.xAxis.labelPosition = .topInside
        lineChart.xAxis.granularity = 1
        lineChart.rightAxis.enabled = false
        lineChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        lineChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        lineChart.leftAxis.axisMinimum = 0
        lineChart.data = data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        
    }
    
    private func loadData() {
        viewModel.loadDataFromSQL()
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]){
        var dataEntries : [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            if(values.count == 0){
                let dummy  = [1.0,2.0,3.0,4.0,5.0]
                let dataEntry = PieChartDataEntry(value: dummy[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
                
            }else{
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
                
            }
            
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "---- Income and Expenses")
        pieChartDataSet.colors = colorsOfCharts(numbbersOfColor: dataPoints.count)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieView.data = pieChartData
    }
    
    private func colorsOfCharts(numbbersOfColor: Int) -> [UIColor] {
        var colors : [UIColor] = []
        for _ in 0..<numbbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
   
    
}


