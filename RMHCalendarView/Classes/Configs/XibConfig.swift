//
//  XibConfig.swift
//  Pods-RMHCalendarView_Example
//
//  Created by Reed Hogan on 11/1/17.
//

import Foundation

public struct XibConfig {
    let name: String
    let resuseIdentifier: String
    let bundle: Bundle
    
    public init(name: String, resuseIdentifier: String, bundle: Bundle = Bundle.main) {
        self.name = name
        self.resuseIdentifier = resuseIdentifier
        self.bundle = bundle
    }
}
