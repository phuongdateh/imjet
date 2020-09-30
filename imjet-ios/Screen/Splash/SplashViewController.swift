//
//  InitImjetViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    static let storyBoardId: String = "SplashViewController"
    static let storyboardName: String = "Splash"
    
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var isFirstTimesAppeared: Bool = true
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AuthenticationService.accessToken == nil {
            AuthenticationService.lauchLoginView()
        }
        else {
            AuthenticationService.lauchHomeView(launchOptions)
        }
        
    }
}
