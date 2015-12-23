//
//  SecondViewController.swift
//  iosChartsExample
//
//  Created by Erle Bridgewater on 12/14/15.
//  Copyright © 2015 Erle Bridgewater. All rights reserved.
//

import UIKit
import Charts

//This is mostly the same as the first controller, adapted for a line graph.

class SecondViewController: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var lineChart: LineChartView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gregorian = NSCalendar.init(identifier: NSCalendarIdentifierGregorian)
        
        //let sourceData = appDelegate.dateArray
        let sourceData = appDelegate.groupedDates
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        lineChart.delegate = self
        //No need for the description text here, and it really just gets in the way
        lineChart.descriptionText = ""
        
        
        //Set up some formatting
        let xAxis = lineChart.xAxis
        
        //Setting up the formatting of the xaxis
        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10);
        xAxis.drawGridLinesEnabled = false;
        xAxis.spaceBetweenLabels = 0;
        
        
        //init yval array of DataEntry objects
        var yvals = [ChartDataEntry]()
        
        //A string array to hold the xvalues, which are represented as Strings here
        var xvals = [String]()
        
        //init a start date 59 days ago
        let offsetComponents = NSDateComponents()
        offsetComponents.day = -59
        var currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: NSDate(), options: []))!
        
        //Create a formatter to turn dates into strings
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        //After the init of the date, we will be advancing one day at a time
        offsetComponents.day = 1
        
        
        for var i = 0 ; i<60; i++
        {
            
            //Extract the data as ChartDataEntry items and add them to a new array
            
            let data = ChartDataEntry.init(value: sourceData[i], xIndex: i)
            yvals.append(data)
            
            //increment dates one by one, adding it to
            let dateText = formatter.stringFromDate(currentDate)
            currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: currentDate, options: []))!
            
            
            xvals.append(dateText)
        }
        //Need to initilize the data set with the yvalues
        let set1 = LineChartDataSet.init(yVals: yvals, label: "Test")
        
        //init the main data object with the xvals, and the data set. We only have one set here, but we could have a multi chart by having multiple sets.
        let data = LineChartData.init(xVals: xvals, dataSets: [set1])
        
        //Set up the numformatter for the chart so that we dont get things like 4.00 instead of just 4, since we will always have whole numbers
        let numFormatter = NSNumberFormatter()
        numFormatter.generatesDecimalNumbers = false
        numFormatter.maximumFractionDigits = 1
        
        
        data.setValueFormatter(numFormatter)
        
        
        //Set the chart data object
        lineChart.data=data    }
    
    
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

