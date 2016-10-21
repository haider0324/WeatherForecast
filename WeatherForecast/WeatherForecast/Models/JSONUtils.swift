//
//  JSONUtils.swift
//  Collections
//
//  Created by Haider Abbas on 25/03/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import Foundation

// Helper Protocol

protocol JSONParselable {
    static func withJSON(json: [String:AnyObject]) -> Self?
}

// Helper Data Type

public typealias JSONDictionary = [String: AnyObject]

// Helper functions:

// The flatten(_:) function takes a double optional and removes one level of optional-ness.
func flatten<A>(x: A??) -> A? {
    if let y = x { return y }
    return nil
}

// The custom operator >>>= takes an optional of type A to the left, and a function that takes an A as a parameter and returns an optional B to the right. Basically, it says "apply."
infix operator >>>= {}

func >>>= <A, B> (optional: A?, f: A -> B?) -> B? {
    return flatten(optional.map(f))
}

// Retrieve Data from JSON structures in a type-safe manner

func number(input: [NSObject:AnyObject], key: String) -> NSNumber? {
    return input[key] >>>= { $0 as? NSNumber }
}

func int(input: [NSObject:AnyObject], key: String) -> Int? {
    return number(input, key: key).map { $0.integerValue }
}

func float(input: [NSObject:AnyObject], key: String) -> Float? {
    return number(input, key: key).map { $0.floatValue }
}

func double(input: [NSObject:AnyObject], key: String) -> Double? {
    return number(input, key: key).map { $0.doubleValue }
}

func string(input: [String:AnyObject], key: String) -> String? {
    return input[key] >>>= { $0 as? String }
}

func bool(input: [String:AnyObject], key: String) -> Bool? {
    return number(input, key: key).map { $0.boolValue }
}

// Retrieve Data from JSON structures to Array and Dictionary in a type-safe manner

func dictionary(input: [String: AnyObject], key: String) ->  [String: AnyObject]? {
    return input[key] >>>= { $0 as? [String:AnyObject] }
}

func array(input: [String:AnyObject], key: String) ->  [AnyObject]? {
    return input[key] >>>= { $0 as? [AnyObject] }
}


