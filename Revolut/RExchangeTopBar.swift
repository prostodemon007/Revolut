//
//  RExchangeTopBar.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 05.07.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit

class RExchangeTopBar: UIView {
    let btnCancel = UIButton()
    let btnExchange = UIButton()
    var lblTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btnCancel.setTitleColor(UIColor.whiteColor())
        btnCancel.setTitle("Cancel")
        btnCancel.titleLabel?.font = UIFont.light(16)
        
        btnExchange.setTitleColor(UIColor.whiteColor())
        btnExchange.setTitle("Exchange")
        btnExchange.titleLabel?.font = UIFont.light(16)
        
        lblTitle.layer.cornerRadius = 5
        lblTitle.layer.borderColor = UIColor(white: 1, alpha: 0.4).CGColor
        lblTitle.layer.borderWidth = 1
        lblTitle.layer.masksToBounds = true
        lblTitle.backgroundColor = UIColor(white: 0, alpha: 0.1)
        lblTitle.textAlignment = .Center
        lblTitle.textColor = UIColor.whiteColor()
        lblTitle.font = UIFont.light(14)
        
        
        self.addSubview(lblTitle)
        self.addSubview(btnExchange)
        self.addSubview(btnCancel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnCancel.sizeToFit()
        btnCancel.height = self.height
        btnCancel.width += 10
        
        btnExchange.sizeToFit()
        btnExchange.height = self.height
        btnExchange.width += 10
        btnExchange.right = width
        
        lblTitle.frame = CGRectMake(0, 0, width * 0.4 , height)
        lblTitle.centerX = width / 2
    }
}
