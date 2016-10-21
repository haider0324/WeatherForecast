//
//  NSURLSessionConfiguration+APIClient.swift
//  WeatherForecast
//
//  Created by Haider Abbas on 20/10/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import Foundation

extension NSURLSessionConfiguration {
    
    /// Just like defaultSessionConfiguration, returns a newly created session configuration object, customised
    /// from the default to your requirements.
    class func weatherSessionConfiguration() -> NSURLSessionConfiguration {
        let config = defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 30 // Make things timeout quickly.
        config.HTTPAdditionalHeaders = ["MyResponseType": "JSON"] // My web service needs to be explicitly asked for JSON.
        config.HTTPShouldUsePipelining = true // Might speed things up if your server supports it.
        return config
    }
    
}