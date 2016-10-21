//
//  NSURLSession+APIClient.swift
//  WeatherForecast
//
//  Created by Haider Abbas on 20/10/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import Foundation

extension NSURLSession {
    
    /// Just like sharedSession, this returns a shared singleton session object.
    class var sharedWeatherSession: NSURLSession {
        // The session is stored in a nested struct because you can't do a 'static let' singleton in a class extension.
        struct Instance {
            /// The singleton URL session, configured to use our custom config and delegate.
            static let session = NSURLSession(
                configuration: NSURLSessionConfiguration.weatherSessionConfiguration(),
                delegate: WeatherURLSessionDelegate(), // Delegate is retained by the session.
                delegateQueue: NSOperationQueue.mainQueue())
        }
        return Instance.session
    }
    
}