//
//  AppDelegate.swift
//  iosChartsExample
//
//  Created by Erle Bridgewater on 12/14/15.
//  Copyright © 2015 Erle Bridgewater. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dateArray : [NSDate] = [NSDate]()

    var groupedDates = [Double](count: 60, repeatedValue: 0.0)

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        for var i = 0 ; i<100; i++
        {
            dateArray.append(generateRandomDateWithinDaysBeforeToday(60))
        }
        //lets sort these
        dateArray.sortInPlace{ (element2, element1) -> Bool in

            //if they are the same dont worry. need ascending and descending to have different results though so
            if element1.compare(element2) == NSComparisonResult.OrderedDescending{
                return true
            }
            return false
        }
        
        var currentDay = 0
        
        let unitFlags: NSCalendarUnit = [.Month,.Day]
        
        let gregorian = NSCalendar.init(identifier: NSCalendarIdentifierGregorian)

        let offsetComponents = NSDateComponents()
        offsetComponents.day = -59
        
        var currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: NSDate(), options: []))!
        
        var currentDateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: currentDate)
        
        for var i = 0 ; i<100; i++
        {
            let nextComp = NSCalendar.currentCalendar().components(unitFlags, fromDate: dateArray[i]);
            
            while nextComp.day != currentDateComponents.day
            {
                offsetComponents.day=1
                
                currentDate = (gregorian?.dateByAddingComponents(offsetComponents, toDate: currentDate, options: []))!
                currentDateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: currentDate)
                
                currentDay++
            }
            
            groupedDates[currentDay] = groupedDates[currentDay]+1
            
            
        }

        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    //http://stackoverflow.com/questions/10092468/how-do-you-generate-a-random-date-in-objective-c 
    //Pulled from stack overflow and translated from ObjC
    func generateRandomDateWithinDaysBeforeToday(days: Int) -> NSDate
    {
        let r1 = arc4random_uniform(UInt32(days))
        let r2 = 0//arc4random_uniform(23)
        let r3 = 0//arc4random_uniform(59);
        
        let today = NSDate()
        let gregorian = NSCalendar.init(identifier: NSCalendarIdentifierGregorian)
        
        let offsetComponents = NSDateComponents()
        
        offsetComponents.day  = (Int(r1) * -1)
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        
        let rndDate1 = gregorian?.dateByAddingComponents(offsetComponents, toDate: today, options: [])
        
        return rndDate1!
        
    }



}

