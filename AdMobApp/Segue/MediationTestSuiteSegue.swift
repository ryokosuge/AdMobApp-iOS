//
//  MediationTestSuiteSegue.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/04.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAdsMediationTestSuite

class MediationTestSuiteSegue: UIStoryboardSegue {

    override func perform() {
        GoogleMobileAdsMediationTestSuite.present(on: source, delegate: nil)
    }

}
