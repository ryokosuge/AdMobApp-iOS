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
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        adUnitIDLabel?.text = nil
    }
    
}

extension InterstitialViewController {

    @IBAction func loadAd(_ button: UIButton) {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Consts.AdUnitID.interstitial, request: request) {[weak self] (ad, error) in
            if let error = error {
                print(#function, error)
                self?.showButton?.isEnabled = false
                return
            }

            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
        }
    }
    
    @IBAction func showAd(_ button: UIButton) {
        guard let interstitial = self.interstitial else {
            return
        }

        interstitial.present(fromRootViewController: self)
    }

}

extension InterstitialViewController: GADFullScreenContentDelegate {

    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print(#function, ad, error)
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
        print(#function, ad)
        showButton?.isEnabled = false
        adUnitIDLabel?.text = nil
    }

    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
    }

}
