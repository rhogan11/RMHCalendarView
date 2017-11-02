//
//  Theme.swift
//  Calendar
//
//  Created by Reed Hogan on 10/27/17.
//  Copyright © 2017 Reed Hogan. All rights reserved.
//

import UIKit


public protocol ThemeProtocol {
    var borderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var lineColor: UIColor { get }
}

extension ThemeProtocol { //defaults for protocol
    public var borderColor : UIColor {
        return UIColor(red: (20/255), green: (102/255), blue: (198/255), alpha: (255/255))
    }
    
    public var backgroundColor : UIColor {
        return UIColor(red: (150/255), green: (198/255), blue: (249/255), alpha: (255/255))
    }
    
    public var lineColor : UIColor {
        return UIColor(red: (170/255), green: (208/255), blue: (252/255), alpha: (100/255)) 
    }
}

public class Theme: ThemeProtocol {//default struct using protocol
    public init(){}
}
