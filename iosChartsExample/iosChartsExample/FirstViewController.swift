//
//  FirstViewController.swift
//  iosChartsExample
//
//  Created by Erle Bridgewater on 12/14/15.
//  Copyright © 2015 Erle Bridgewater. All rights reserved.
//

import UIKit
import Charts


class FirstViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var barChart: BarChartView!
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gregorian = NSCalendar.init(identifier: NSCalendarIdentifierGregorian)

        //let sourceData = appDelegate.dateArray
        let sourceData = appDelegate.groupedDates
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        barChart.delegate = self
        
        barChart.descriptionText = ""
        
        //var yAxis = barChart.leftAxis
        
        
        
        let xAxis = barChart.xAxis

        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        
        


        xAxis.labelFont = UIFont.systemFontOfSize(10);
        
        xAxis.drawGridLinesEnabled = false;
        xAxis.spaceBetweenLabels = 1;

        
        
        var yvals = [BarChartDataEntry]()
        
        let offsetComponents = NSDateComponents()
        offsetComponents.day = -59
        
        for var i = 0 ; i<59; i++
        {
         
            let data = BarChartDataEntry.init(value: sourceData[i], xIndex: i)
            yvals.append(data)
        }
        
        
        
        var xvals = [String]()
        offsetComponents.day = -60
        
        
        var currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: NSDate(), options: []))!
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        offsetComponents.day = 1

        for var i = 0 ; i<60; i++
        {
            
            let dateText = formatter.stringFromDate(currentDate)
            currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: currentDate, options: []))!

            
            xvals.append(dateText)
        }
        
        let set1 = BarChartDataSet.init(yVals: yvals, label: "Test")

        let data = BarChartData.init(xVals: xvals, dataSets: [set1])
        
        
        let numFormatter = NSNumberFormatter()
        numFormatter.generatesDecimalNumbers = false
        numFormatter.maximumFractionDigits = 1

        
        data.setValueFormatter(numFormatter)

        barChart.data=data
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

