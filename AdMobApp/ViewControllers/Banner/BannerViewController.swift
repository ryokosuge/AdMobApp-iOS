//
//  BannerViewController.swift
//  AdMobMCM
//
//  Created by ryokosuge on 2020/03/03.
//  Copyright © 2020 fluct, inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

enum BannerAdSize: String {
    case banner = "320x50"
    case mediumRectangle = "300x250"
    case largeBanner = "320x100"

    var adUnitID: String {
        switch self {
        case .banner:
            return Consts.AdUnitID.banner
        case .mediumRectangle:
            return Consts.AdUnitID.mediumRectangle
        case .largeBanner:
            return Consts.AdUnitID.largeBanner
        }
    }

    var adSize: GADAdSize {
        switch self {
        case .banner:
            return kGADAdSizeBanner
        case .mediumRectangle:
            return kGADAdSizeMediumRectangle
        case .largeBanner:
            return kGADAdSizeLargeBanner
        }
    }
}

class BannerSegue: UIStoryboardSegue {

    override func perform() {
        if let bannerViewController = destination as? BannerViewController {
            let bannerAdSize = BannerAdSize(rawValue: identifier ?? "") ?? .banner
            bannerViewController.bannerAdSize = bannerAdSize
        }
        
        source.navigationController?.pushViewController(destination, animated: true)
    }

}

class BannerViewController: UIViewController {

    @IBOutlet weak var adUnitIDLabel: UILabel?

    var bannerAdSize: BannerAdSize = .banner

    private var bannerView: GADBannerView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        adUnitIDLabel?.text = "Loading..."
        navigationItem.title = bannerAdSize.rawValue
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBanner()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bannerView?.center = view.center
    }

}

extension BannerViewController {
    
    @IBAction func refreshAd() {
        bannerView?.load(GADRequest())
    }
    
    private func loadBanner() {
        let bannerView = GADBannerView(adSize: bannerAdSize.adSize)
        bannerView.adUnitID = bannerAdSize.adUnitID
        bannerView.rootViewController = self
        bannerView.delegate = self

        view.addSubview(bannerView)
        self.bannerView = bannerView
        bannerView.load(GADRequest())
    }

    private func clearBanner() {
        bannerView?.removeFromSuperview()
        bannerView?.delegate = nil
        bannerView?.rootViewController = nil
        bannerView = nil
    }

}

extension BannerViewController: GADBannerViewDelegate {

    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function, bannerView)
        adUnitIDLabel?.text = bannerView.adUnitID
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print(#function, bannerView, error)
        adUnitIDLabel?.text = "Error:   \n\(error.localizedDescription)"
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print(#function, bannerView)
    }

}
