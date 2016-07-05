//
//  ExchangeManager.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 03.07.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit
import AFNetworking

let kNotificationCurrencyRefreshed = "kNotificationCurrencyRefreshed"

private let serverUrl = "http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml"
class ExchangeManager {
    private static let availaibleCurrencies = ["USD","EUR","GBP"]
    private static let currencySigns = ["$","€","£"]
    private static var timer : NSTimer!
    
    
    static var currencies : [Currency] = {
        let currency = Currency()
        currency.rate = 1
        currency.shortName = "EUR"
        currency.symbol = "€"
        return [currency]
    }()
    
    

    static func refresh(completion : (succees : Bool) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFXMLParserResponseSerializer()
        manager.POST(serverUrl, parameters: nil, progress: nil, success: { (task, object) in
            let parser = object as! NSXMLParser
            let dict = NSDictionary(XMLParser: parser)
            let currenciesArr = dict["Cube"]!["Cube"]!!["Cube"] as! [[String:AnyObject]]
            
            for currencyDict in currenciesArr {
                let shortName = currencyDict["_currency"] as! String
                let rate = (currencyDict["_rate"] as! String).floatValue
                addOrUpdateCurrency(shortName, rate: rate)
            }
            
            if timer == nil {
                timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(refreshTimerTick), userInfo: nil, repeats: true)
            }
            
            completion(succees: true)
        }) { (task, error) in
            completion(succees: false)
        }
    }
    
    @objc static func refreshTimerTick() {
        refresh { (succees) in
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: kNotificationCurrencyRefreshed, object: nil))
        }
    }
    
    static func addOrUpdateCurrency(shortName : String, rate : Float) {
        var found = false
        for currency in currencies {
            if shortName == currency.shortName {
                currency.rate = rate
                found = true
                break
            }
        }
        if !found {
            
            for (index,shortN) in availaibleCurrencies.enumerate() {
                if shortName == shortN {
                    let currency = Currency()
                    currency.rate = rate
                    currency.shortName = shortName
                    currency.symbol = currencySigns[index]
                    currencies.append(currency)
                }
            }
        }
    }
    
    
    
    
    static func exchange(amount : Float, fromCurrency : Currency, toCurrency : Currency) -> Float {
        return amount / fromCurrency.rate * toCurrency.rate
    }
    static func exchangeRevert(amount : Float, fromCurrency : Currency, toCurrency : Currency) -> Float {
        return amount * fromCurrency.rate / toCurrency.rate
    }
}

