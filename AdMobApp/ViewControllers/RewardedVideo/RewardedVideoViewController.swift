//
//  RewardedVideoViewController.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/04.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds
// import GoogleMobileAdsMediationFluct

class RewardedVideoViewController: UIViewController {

    @IBOutlet weak var adNetworkClassNameLabel: UILabel?
    @IBOutlet weak var adUnitIDLabel: UILabel?
    @IBOutlet weak var showButton: UIButton?

    private var rewardedAd: GADRewardedAd?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        adUnitIDLabel?.text = nil
        adNetworkClassNameLabel?.text = nil
    }

}

extension RewardedVideoViewController {

    @IBAction func loadAd(_ button: UIButton) {
        showButton?.isEnabled = false

        // let extra = GADMAdapterFluctExtras()
        // extra.setting = FSSRewardedVideoSetting.default
        // extra.setting?.isDebugMode = true
        let request = GADRequest()
        // request.register(extra)

        GADRewardedAd.load(withAdUnitID: Consts.AdUnitID.rewardedVideo, request: request) {[weak self] (ad, error) in
            if let error = error {
                print(error)
                return
            }

            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            
            self?.adUnitIDLabel?.text = ad?.adUnitID
            self?.adNetworkClassNameLabel?.text = ad?.responseInfo.adNetworkClassName
            self?.showButton?.isEnabled = true
        }

    }

    @IBAction func showAd(_ button: UIButton) {
        guard let rewardedAd = self.rewardedAd else {
            return
        }

        rewardedAd.present(fromRootViewController: self) {[rewardedAd] in
            print(#function, rewardedAd, rewardedAd.adReward)
        }
    }

}

extension RewardedVideoViewController: GADFullScreenContentDelegate {

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
