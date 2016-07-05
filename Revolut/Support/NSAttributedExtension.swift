//
//  NSAttributedExt.swift
//  VolKey
//
//  Created by Oleg Ulitsionak on 21.02.16.
//  Copyright © 2016 TotoVentures. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func buildAttributedStrings(strings: [String], fonts:[UIFont]) -> NSAttributedString {
        let string = NSMutableAttributedString()
        for (idx,str) in strings.enumerate() {
            let attrStr = NSAttributedString(string: str, attributes: [NSFontAttributeName:fonts[idx]])
            string.appendAttributedString(attrStr)
        }
    return string;
    }
    
    static func buildAttributedStrings(strings: [String], fonts:[UIFont], colors : [UIColor]) -> NSAttributedString {
        let string = NSMutableAttributedString()
        for (idx,str) in strings.enumerate() {
            let attrStr = NSAttributedString(string: str, attributes: [NSFontAttributeName:fonts[idx],NSForegroundColorAttributeName:colors[idx]])
            string.appendAttributedString(attrStr)
        }
        return string;
    }    
}
