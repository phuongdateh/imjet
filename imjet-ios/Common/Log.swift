//
//  Log.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import SwiftyBeaver

public typealias Log = SwiftyBeaver

public func setupLogger() {
    // SwiftyBeaver logging
    let console = ConsoleDestination()  // log to Xcode Console
    // use custom format and set console output to short time, log level & message
    console.format = "$DHH:mm:ss$d $C$L$c $M"
    console.minLevel = .verbose // just log .info, .warning & .error
    SwiftyBeaver.addDestination(console)
    
//    let file = FileDestination()
//    SwiftyBeaver.addDestination(file)
}
