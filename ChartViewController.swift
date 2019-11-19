//
//  ChartViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/10/27.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    var chartView: LineChartView!
    
    var lineDataSet: LineChartDataSet!
    
//    var data1: [Any] = []
//    var data2: [Any] = []
//    var data3: [Any] = []
//    var data4: [Any] = []
//    var data5: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plotDatas = [55.0, 100.0, 88.0, 99.0, 77.0]
        initDisplay(y: plotDatas)
        // Do any additional setup after loading the view.
    }
    
    func initDisplay(y: [Double]) {
           
           
           self.chartView = LineChartView(frame: CGRect(x: 0, y: (self.view.frame.height / 2) - 200, width: self.view.frame.width, height: 400))
    
           // プロットデータ(y軸)を保持する配列
           var dataEntries = [ChartDataEntry]()
           
           for (i, val) in y.enumerated() {
               let dataEntry = ChartDataEntry(x: Double(i), y: val) // X軸データは、0,1,2,...
               dataEntries.append(dataEntry)
           }
        lineDataSet = LineChartDataSet(entries: dataEntries, label: "")
               chartView.data = LineChartData(dataSet: lineDataSet)
               
               // x軸のラベルをボトムに表示
               chartView.xAxis.labelPosition = .bottom
               // x軸のラベル数をデータの数に設定
               chartView.xAxis.labelCount = dataEntries.count - 1
               // タップでプロットを選択できないようにする
               chartView.highlightPerTapEnabled = false
               chartView.leftAxis.axisMaximum = 100 //y左軸最大値
               chartView.leftAxis.axisMinimum = 0 //y左軸最小値
               chartView.leftAxis.labelCount = 5 //y軸ラベルの表示数
               chartView.leftAxis.drawTopYLabelEntryEnabled = true // y軸の最大値のみ表示
               chartView.leftAxis.forceLabelsEnabled = true //最小最大値ラベルを必ず表示?
               chartView.rightAxis.enabled = false // Y軸右軸(値)を非表示
               chartView.extraTopOffset = 25 // 上から20pxオフセット
               chartView.legend.enabled = false // 左下のラベル非表示
               chartView.pinchZoomEnabled = false // ピンチズームオフ
               chartView.doubleTapToZoomEnabled = false // ダブルタップズームオフ
               // グラフアニメーション
               chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
               // グラフの色
               lineDataSet.colors = [UIColor.green]
               // プロットの色
               lineDataSet.circleColors = [UIColor.red]
               // プロットの大きさ
               lineDataSet.circleRadius = 5.0
        
               // 描画
               self.view.addSubview(self.chartView)
               
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
