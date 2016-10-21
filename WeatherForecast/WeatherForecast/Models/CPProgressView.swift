//
//  CPProgressView.swift
//  Collections
//
//  Created by Haider Abbas on 28/03/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import UIKit

public class CPProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    public class var shared: CPProgressView {
        struct Static {
            static let instance: CPProgressView! = CPProgressView()
        }
        return Static.instance
    }
    
    public func showProgressView(){
        containerView.frame = appDelegate.window!.frame
        containerView.center = appDelegate.window!.center
        containerView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        
        progressView.frame = CGRectMake(0, 0, 80, 80)
        progressView.center = appDelegate.window!.center
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        if (ISIPAD) {
            activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        }
        else{
            activityIndicator.activityIndicatorViewStyle = .White
        }
        activityIndicator.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        appDelegate.window!.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
