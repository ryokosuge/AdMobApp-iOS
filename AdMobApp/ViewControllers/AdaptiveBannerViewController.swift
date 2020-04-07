//
//  AdaptiveBannerViewController.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/04.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdaptiveBannerViewController: UIViewController {

    @IBOutlet weak var adUnitIDLabel: UILabel?
    private var bannerView: GADBannerView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bannerView = GADBannerView(adSize: kGADAdSizeFluid)
        bannerView.adUnitID = Consts.AdUnitID.adaptiveBanner
        bannerView.rootViewController = self
        bannerView.delegate = self
        view.addSubview(bannerView)
        self.bannerView = bannerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBannerAd()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bannerView?.center = view.center
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {[weak self] _ in
            self?.loadBannerAd()
        }, completion: nil)
    }
}

extension AdaptiveBannerViewController {

    @IBAction func refreshAd() {
        loadBannerAd()
    }

    private func loadBannerAd() {
        adUnitIDLabel?.text = "Loading..."

        let viewWidth = view.frame.width
        bannerView?.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView?.load(GADRequest())
    }

}

extension AdaptiveBannerViewController: GADBannerViewDelegate {

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function, bannerView)
        adUnitIDLabel?.text = bannerView.adUnitID
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(#function, bannerView, error)
        adUnitIDLabel?.text = "Error:   \n\(error.localizedDescription)"
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }
    
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }

}
