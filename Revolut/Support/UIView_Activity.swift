//
//  UIView_Activity.swift
//  MobCast
//
//  Created by user on 01.10.15.
//
//

import UIKit
import ObjectiveC

extension UIView {
    private struct AssociatedKey {
        static var activity = "activityRuntimeKey"
    }
    
    var activity: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.activity) as? UIActivityIndicatorView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKey.activity, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showActivity() {
        if activity == nil {
            activity = UIActivityIndicatorView(frame: self.bounds)
            activity!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            activity!.backgroundColor = UIColor(white: 0, alpha : 0.1)
            activity!.activityIndicatorViewStyle = .WhiteLarge
        }
        activity!.frame = self.bounds
        activity!.startAnimating()
        self.addSubview(activity!)
    }
    
    func hideActivity() {
        activity?.removeFromSuperview()
    }
}
