//
//  RVCCurrency.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 24.06.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit

class RVCCurrency: UIViewController {
    let currencyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyLabel.textColor = UIColor.whiteColor()
        currencyLabel.textAlignment = .Center
        currencyLabel.font = UIFont.light(30)
        self.view.addSubview(currencyLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        currencyLabel.frame = CGRectMake(0, 0, view.width / 2, view.height)
    }
    
}
