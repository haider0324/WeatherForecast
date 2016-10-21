//
//  Constants.swift
//  WeatherForecast
//
//  Created by Haider Abbas on 20/10/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import Foundation
import UIKit

let WEATHERAPIKEY: String = "697368c8a0a3902d0b19df0de87222e1"

public let ISIPAD = (UIDevice.currentDevice().userInterfaceIdiom == .Pad)

public let SearchControllerFont = ISIPAD ? UIFont (name: "HelveticaNeue-Medium", size: 24) : UIFont (name: "HelveticaNeue-Medium", size: 20)
public let searchCellFont = ISIPAD ? UIFont (name: "HelveticaNeue-Regular", size: 16) : UIFont (name: "HelveticaNeue-Regular", size: 12)

public struct WEATHERAPI {
    static let FORECAST = "forecast"
}
