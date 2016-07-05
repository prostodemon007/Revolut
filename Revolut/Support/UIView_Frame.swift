//
//  UIView_Frame.swift
//  qwix
//
//  Created by Алексей on 05.02.15.
//  Copyright (c) 2015 StudioMobile. All rights reserved.
//

import UIKit

extension UIView
{
    var top : CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame = CGRectMake(self.frame.minX,newValue,self.frame.width,self.frame.height)
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.frame = CGRectMake(self.frame.minX,newValue - self.frame.height,self.frame.width,self.frame.height)
        }
    }

    var left : CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame = CGRectMake(newValue,self.frame.minY,self.frame.width,self.frame.height)
        }
    }

    var right : CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            self.frame = CGRectMake(newValue - self.frame.width, self.frame.minY, self.frame.width, self.frame.height)
        }
    }
    var width : CGFloat  {
        get  {
            return self.frame.width
        }
        set {
            self.frame = CGRectMake(self.frame.minX, self.frame.minY, newValue, self.frame.height)
        }
    }
    var height : CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame = CGRectMake(self.frame.minX, self.frame.minY, self.frame.width, newValue)
        }
    }

    var centerY : CGFloat {
        get {
            return self.frame.minY + self.frame.height / 2
        }
        set {
            self.frame = CGRectMake(self.frame.minX,newValue - self.frame.height / 2,self.frame.width,self.frame.height)
        }
    }
    
    var centerX : CGFloat {
        get {
            return self.frame.minX + self.frame.width / 2
        }
        set {
            self.frame = CGRectMake(newValue - self.frame.width / 2,self.frame.minY,self.frame.width,self.frame.height)
        }
    }
    
}
