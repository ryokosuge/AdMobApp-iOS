//
//  InterstitialViewController.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/04.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterstitialViewController: UIViewController {

    @IBOutlet weak var adUnitIDLabel: UILabel?
    @IBOutlet weak var showButton: UIButton?
    
    private var interstitial: GADInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        adUnitIDLabel?.text = nil
    }
    
}

extension InterstitialViewController {

    @IBAction func loadAd(_ button: UIButton) {
        interstitial = GADInterstitial(adUnitID: Consts.AdUnitID.interstitial)
        interstitial?.delegate = self
        interstitial?.load(GADRequest())
    }
    
    @IBAction func showAd(_ button: UIButton) {
        guard let interstitial = self.interstitial, interstitial.isReady else {
            return
        }

        interstitial.present(fromRootViewController: self)
    }

}

extension InterstitialViewController: GADInterstitialDelegate {

    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print(#function, ad)
        adUnitIDLabel?.text = ad.adUnitID
        showButton?.isEnabled = true
    }

    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print(#function, ad, error)
        showButton?.isEnabled = false
    }

    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print(#function, ad)
    }

    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print(#function, ad)
    }

    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print(#function, ad)
    }

    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print(#function, ad)
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print(#function, ad)
        showButton?.isEnabled = false
        adUnitIDLabel?.text = nil
    }

}
