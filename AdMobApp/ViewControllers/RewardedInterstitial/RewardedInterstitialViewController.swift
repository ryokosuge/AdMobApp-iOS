//
//  RewardedInterstitialViewController.swift
//  AdMobApp
//
//  Created by ryokosuge on 2021/03/18.
//  Copyright © 2021 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds
import GoogleMobileAdsMediationFluct

class RewardedInterstitialViewController: UIViewController {

    @IBOutlet weak var adNetworkClassNameLabel: UILabel?
    @IBOutlet weak var adUnitIDLabel: UILabel?
    @IBOutlet weak var showButton: UIButton?

    private var rewardedInterstitialAd: GADRewardedInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        adUnitIDLabel?.text = nil
        adNetworkClassNameLabel?.text = nil
    }

}

extension RewardedInterstitialViewController {

    @IBAction func loadAd(_ button: UIButton) {
        showButton?.isEnabled = false

        let extra = GADMAdapterFluctExtras()
        extra.setting = FSSRewardedVideoSetting.default
        extra.setting?.isDebugMode = true
        let request = GADRequest()
        request.register(extra)

        GADRewardedInterstitialAd.load(withAdUnitID: Consts.AdUnitID.rewardedInterstitial, request: request) {[weak self] (ad, error) in
            if let error = error {
                print(error)
                return
            }

            self?.rewardedInterstitialAd = ad
            self?.rewardedInterstitialAd?.fullScreenContentDelegate = self

            self?.adUnitIDLabel?.text = ad?.adUnitID
            self?.adNetworkClassNameLabel?.text = ad?.responseInfo.adNetworkClassName
            self?.showButton?.isEnabled = true
        }

    }

    @IBAction func showAd(_ button: UIButton) {
        guard let rewardedInterstitialAd = self.rewardedInterstitialAd else {
            return
        }

        rewardedInterstitialAd.present(fromRootViewController: self) {[rewardedInterstitialAd] in
            print(#function, rewardedInterstitialAd, rewardedInterstitialAd.adReward)
        }
    }

}

extension RewardedInterstitialViewController: GADFullScreenContentDelegate {

    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print(#function, ad, error)
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
        showButton?.isEnabled = false
        adNetworkClassNameLabel?.text = nil
        adUnitIDLabel?.text = nil
    }

    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print(#function, ad)
    }

}
