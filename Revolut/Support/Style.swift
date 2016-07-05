//
//  Style.swift
//  qwix
//
//  Created by Алексей on 07.02.15.
//  Copyright (c) 2015 StudioMobile. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g:Int , b:Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
    convenience init(r: Int, g:Int , b:Int, a:Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
    
    class func tealColor () -> UIColor {
            return UIColor(red: 102/255.0, green: 152/255.0, blue: 178/255.0, alpha: 1)
    }

    convenience init(white256 : Int) {
        self.init(white : CGFloat(white256)/255 ,alpha : 1)
    }

}

extension UIFont {
    class func light(size : CGFloat) ->UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    class func normal(size : CGFloat) ->UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func regular(size : CGFloat) ->UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func bold(size : CGFloat) ->UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    
}

