//
//  RTextFieldCurrency.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 26.06.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit

class RTextFieldCurrency: UITextField, UITextFieldDelegate {
    var currency : Float {
        get {
            return currentString.floatValue / 100
        }
        set {
            currentString = "\(Int(newValue * 100))"
            formatCurrency(currentString)
        }
    }
    var currentString = ""
    var sign : String = "" {
        didSet {
            formatCurrency(currentString)
        }
    }
    
    var currencyDelgate : RTextFieldCurrencyProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        font = UIFont.light(30)
        textColor = UIColor.whiteColor()
        keyboardType = .NumberPad
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.length > 0 {
            if currentString.length < 8 {
                currentString += string
            }
        } else {
            if currentString.length > 0 {
                currentString.removeAtIndex(currentString.endIndex.predecessor())
            }
        }
        
        formatCurrency(currentString)
        currencyDelgate?.textFieldValueChanged(self)
        return false

    }
    
    func formatCurrency(string: String) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let numberFromField = (NSString(string: currentString).floatValue) / 100
        var result = formatter.stringFromNumber(numberFromField)!
        result.removeAtIndex(result.startIndex)
        super.text = sign + " " + result
        
    }

}

protocol RTextFieldCurrencyProtocol {
    func textFieldValueChanged(textField : RTextFieldCurrency)
}
