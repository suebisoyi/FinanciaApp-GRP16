

//  ShowChartViewController.swift
//  Financia
//
//  Created by  on 4/17/21.
//

import UIKit
import Charts

class ShowChartViewController: UIViewController {
    private var viewModel = StatementViewModel()
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pieView: PieChartView!
    let statementCat = ["Expenses", "Income"]
    var statementValues : [Int] = []
 
    
    override func viewDidLoad() {
      super.viewDidLoad()
        pieView.legend.font = UIFont.systemFont(ofSize: 15.0)
        loadData()
        let incomeExpense = mainDelegate.sumExpensesIncome()
        statementValues = incomeExpense
        customizeChart(dataPoints: statementCat, values: statementValues.map{ Double($0) })
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
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
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


