//
//  User.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 03.07.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit


let kDefUserCurrencies = "kDefUserCurrencies"

class User {
    static var defUser : User!
    
    var balances : [Balance] = []
    
    class var currentUser : User {
        get {
            return User.defaultUser()
        }
    }
    
    class func defaultUser() -> User {
        if defUser == nil {
            defUser = User()
        }
        return defUser
    }
    
    func fillBalance() {
        for currency in ExchangeManager.currencies {
            let balance = Balance()
            balance.amount = 100
            balance.currency = currency
            balances.append(balance)
        }
    }
    
    func exhchange(amount : Float,fromCurrency : Currency,toCurrency : Currency) -> NSError? {
        let fromBalance = balances.filter { (balance) -> Bool in
            return balance.currency === fromCurrency
            }.last!
        let toBalance = balances.filter { (balance) -> Bool in
            return balance.currency === toCurrency
            }.last!
        
        if fromBalance.amount < amount {
            return NSError(domain: "Exchange", code: 0, userInfo: [NSLocalizedDescriptionKey:"You have " + fromBalance.currency.symbol + "\(fromBalance.amount)"])
        }
        
        fromBalance.amount -= amount
        toBalance.amount += ExchangeManager.exchange(amount, fromCurrency: fromCurrency, toCurrency: toCurrency)
        return nil
    }
}

