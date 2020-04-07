//
//  RewardedVideoViewController.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/04.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds
import GoogleMobileAdsMediationFluct

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

        rewardedAd = GADRewardedAd(adUnitID: Consts.AdUnitID.rewardedVideo)
        let extra = GADMAdapterFluctExtras()
        extra.setting = FSSRewardedVideoSetting.default
        extra.setting?.isDebugMode = true
        let request = GADRequest()
        request.register(extra)
        rewardedAd?.load(request) {[weak self] (error) in
            if let error = error {
                print(error)
                return
            }

            self?.adUnitIDLabel?.text = self?.rewardedAd?.adUnitID
            self?.showButton?.isEnabled = true
            self?.adNetworkClassNameLabel?.text = self?.rewardedAd?.responseInfo?.adNetworkClassName
        }
    }

    @IBAction func showAd(_ button: UIButton) {
        guard let rewardedAd = self.rewardedAd, rewardedAd.isReady else {
            return
        }

        rewardedAd.present(fromRootViewController: self, delegate: self)
    }

}

extension RewardedVideoViewController: GADRewardedAdDelegate {

    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print(#function, rewardedAd, reward)
    }

    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print(#function, rewardedAd, error)
    }

    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print(#function, rewardedAd)
    }

    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        print(#function, rewardedAd)
        adUnitIDLabel?.text = nil
        adNetworkClassNameLabel?.text = nil
        showButton?.isEnabled = false
    }

}
