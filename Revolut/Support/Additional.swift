//
//  Additional.swift
//  qwix
//
//  Created by Алексей on 06.02.15.
//  Copyright (c) 2015 StudioMobile. All rights reserved.
//

import UIKit

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func background(closure:()->()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        closure()
    })
}

func main(closure:()->()) {
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        closure()
    })
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var length : Int {
        return self.characters.count
    }

    mutating func insertCharacter(atIndex index: Int, _ newChar: Character) -> Void {
        var modifiedString = String()
        for (i, char) in self.characters.enumerate() {
            modifiedString += String((i == index) ? newChar : char)
        }
        self = modifiedString
    }

    
    mutating func replaceCharacter(atIndex index: Int, _ newChar: Character) -> Void {
        var modifiedString = String()
        for (i, char) in self.characters.enumerate() {
            modifiedString += String((i == index) ? newChar : char)
        }
        self = modifiedString
    }
    mutating func removeCharacter(atIndex index: Int) -> Void {
        var modifiedString = String()
        for (i, char) in self.characters.enumerate() {
            if (i != index) {
                modifiedString += String(char)
            }
        }
        self = modifiedString
    }
}

extension UIImageView {
    func tintWithColor(color : UIColor?) {
        var image : UIImage!
        if color == nil {
            image = self.image?.imageWithRenderingMode(.AlwaysOriginal)
            self.tintColor = nil
        } else {
            image = self.image?.imageWithRenderingMode(.AlwaysTemplate)
            self.tintColor = color
        }
        self.image = image
    }
}

extension UIButton {
    
    func setTitle(title : String?){
        self.setTitle(title, forState: UIControlState.Normal)
    }
    
    func setImage(image : UIImage?){
        self.setImage(image, forState: UIControlState.Normal)
    }
    
    func setBackgroundImage(image : UIImage){
        self.setBackgroundImage(image, forState: UIControlState.Normal)
    }
    
    func setTitleColor(color :UIColor){
        self.setTitleColor(color, forState: UIControlState.Normal)
    }
    
    func addTarget(target: AnyObject?, action: Selector) {
        self.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func tintWithColor(color : UIColor?) {
        var image : UIImage!
        if color == nil {
            image = self.imageView?.image?.imageWithRenderingMode(.AlwaysOriginal)
            self.tintColor = nil
        } else {
            image = self.imageView?.image?.imageWithRenderingMode(.AlwaysTemplate)
            self.tintColor = color
        }
        self.setImage(image)
    }
}

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {

        return self.filter({$0 as? T == obj}).count > 0
    }
    
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in self.enumerate() {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                    break
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
    
    mutating func remove(object:AnyObject) -> Void
    {
        for (idx, element) in self.enumerate() {
            if element is AnyObject {
                if object === element as? AnyObject {
                    self.removeAtIndex(idx)
                }
            }
        }
    }
    
    func find (includedElement: Element -> Bool) -> Int? {
        for (idx, element) in self.enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}

