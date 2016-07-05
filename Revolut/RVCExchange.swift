//
//  RVCExchange.swift
//  Revolut
//
//  Created by Oleg Ulitsionak on 04.07.16.
//  Copyright © 2016 Alexei Rudakov. All rights reserved.
//

import UIKit

class RVCExchange: UIViewController, InfinitePageViewDelegate, RTextFieldCurrencyProtocol {
    var topBar = RExchangeTopBar()
    var containerView = UIView()
    
    var myCurenciesView : UIView!
    var myCurrenciesPageVC : InfinitePageViewController!
    var myCurrenciesPageControl = UIPageControl()
    
    var toCurenciesView : UIView!
    var toCurrenciesPageVC : InfinitePageViewController!
    var toCurrenciesPageControl = UIPageControl()
    
    var amountTextfield = RTextFieldCurrency()
    var resultTextfield = RTextFieldCurrency()
    
    var fromCurrency : Currency!
    var toCurrency : Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blueColor()
        
        topBar.frame = CGRectMake(0, UIApplication.sharedApplication().statusBarFrame.height, self.view.width, 40)
        topBar.btnCancel.addTarget(self, action: #selector(onBack))
        topBar.btnExchange.addTarget(self, action: #selector(onExchange))
        self.view.addSubview(topBar)
    
        containerView.frame = CGRectMake(0, topBar.bottom, self.view.width, self.view.height - topBar.bottom)
    
        self.view.addSubview(containerView)

        amountTextfield.sign = "-"
        amountTextfield.textAlignment = .Right
        amountTextfield.currencyDelgate = self
        containerView.addSubview(amountTextfield)
        
        resultTextfield.sign = "+"
        resultTextfield.currencyDelgate = self
        resultTextfield.textAlignment = .Right
        containerView.addSubview(resultTextfield)

        myCurrenciesPageControl.numberOfPages = ExchangeManager.currencies.count
        toCurrenciesPageControl.numberOfPages = ExchangeManager.currencies.count
        containerView.addSubview(myCurrenciesPageControl)
        containerView.addSubview(toCurrenciesPageControl)
        
        addCurrenciesViews()
        
        layoutViews()
        
        fromCurrency = ExchangeManager.currencies[0]
        toCurrency = ExchangeManager.currencies[0]
        refreshTopBarTitle()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshAll), name: kNotificationCurrencyRefreshed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        amountTextfield.becomeFirstResponder()
    }
    
    
    func layoutViews() {
        myCurenciesView.frame = CGRectMake(0, 0, containerView.width, containerView.height / 2)
        toCurenciesView.frame = CGRectMake(0, containerView.height / 2, containerView.width, containerView.height / 2)
        
        amountTextfield.frame = CGRectMake(20, 0, myCurenciesView.width - 40, 50)
        amountTextfield.centerY = myCurenciesView.centerY
        resultTextfield.frame = CGRectMake(20, 0, toCurenciesView.width - 40, 50)
        resultTextfield.centerY = toCurenciesView.centerY
        
        myCurrenciesPageControl.frame = CGRectMake(0, 0, myCurenciesView.width, 20)
        myCurrenciesPageControl.bottom = myCurenciesView.bottom
        
        toCurrenciesPageControl.frame = CGRectMake(0, 0, toCurenciesView.width, 20)
        toCurrenciesPageControl.bottom = toCurenciesView.bottom
    }
    
    
    func addCurrenciesViews() {
        var vcs : [UIViewController] = []
        for currency in ExchangeManager.currencies {
            let currencyVC = RVCCurrency()
            currencyVC.currencyLabel.text = currency.shortName
            vcs.append(currencyVC)
        }

        
        myCurrenciesPageVC = InfinitePageViewController(viewControllers: vcs)
        myCurrenciesPageVC.infiniteDelegate = self
        myCurenciesView = myCurrenciesPageVC.view
        myCurenciesView.addGestureRecognizer(UITapGestureRecognizer(target: amountTextfield, action: #selector(becomeFirstResponder)))
        containerView.addSubview(myCurenciesView)
        
        
        vcs = []
        for currency in ExchangeManager.currencies {
            let currencyVC = RVCCurrency()
            currencyVC.currencyLabel.text = currency.shortName
            vcs.append(currencyVC)
        }
        
        toCurrenciesPageVC = InfinitePageViewController(viewControllers: vcs)
        toCurrenciesPageVC.infiniteDelegate = self
        toCurenciesView = toCurrenciesPageVC.view
        toCurenciesView.addGestureRecognizer(UITapGestureRecognizer(target: resultTextfield, action: #selector(becomeFirstResponder)))
        containerView.addSubview(toCurenciesView)
    }
    
    //MARK: - delegates
    func pageViewController(vc : InfinitePageViewController, currentIndex: Int) {
        if vc == myCurrenciesPageVC {
            myCurrenciesPageControl.currentPage = currentIndex
            fromCurrency = ExchangeManager.currencies[currentIndex]
        } else {
            toCurrenciesPageControl.currentPage = currentIndex
            toCurrency = ExchangeManager.currencies[currentIndex]
        }
        refreshResult()
        refreshTopBarTitle()
    }
    
    func textFieldValueChanged(textField : RTextFieldCurrency) {
        if textField.isFirstResponder() {
            if textField == amountTextfield {
               refreshResult()
            }
            else {
                refreshAmount()
            }
        }
    }
    
    //MARK: - refresh methods
    
    func refreshAll() {
        refreshTopBarTitle()
        refreshResult()
    }
    
    func refreshTopBarTitle() {
        topBar.lblTitle.text = fromCurrency.symbol + "1 = " + toCurrency.symbol + "\(fromCurrency.rate/toCurrency.rate)"
    }
    
    func refreshResult() {
        resultTextfield.currency = ExchangeManager.exchange(amountTextfield.currency, fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
    
    func refreshAmount() {
        amountTextfield.currency = ExchangeManager.exchangeRevert(resultTextfield.currency, fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
    
    
    //MARK: - GUI callbacks
    func onBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func onExchange() {
        let error = User.currentUser.exhchange(amountTextfield.currency, fromCurrency: fromCurrency, toCurrency: toCurrency)
        if error == nil {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            let errorLabel = UILabel()
            errorLabel.text = error!.localizedDescription
            errorLabel.font = UIFont.light(18)
            errorLabel.textColor = UIColor.redColor()
            errorLabel.sizeToFit()
            errorLabel.right = amountTextfield.right
            errorLabel.top = amountTextfield.bottom
            errorLabel.alpha = 0
            containerView.addSubview(errorLabel)
            
            UIView.animateWithDuration(0.1, animations: { 
                errorLabel.alpha = 1
                }, completion: { (success) in
                    UIView.animateKeyframesWithDuration(0.3, delay: 2, options: .AllowUserInteraction, animations: { 
                        errorLabel.alpha = 0
                        }, completion: { (success) in
                            errorLabel.removeFromSuperview()
                    })
            })
        }
    }
    
    //MARK: - Keyboard methods
    func keyboardWillShow(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            containerView.frame = CGRectMake(0, topBar.bottom, self.view.width, self.view.height - topBar.bottom - keyboardSize.height)
            layoutViews()
        }
        
    }
}
