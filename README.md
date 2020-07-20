# AdMob check for iOS App

## setup

```
$ make ADMOB_APP_ID=a BANNER_ADUNIT_ID=b LARGE_BANNER_ADUNIT_ID=c MEDIUM_RECTANGLE_ADUNIT_ID=d ADAPTIVE_BANNER_ADUNIT_ID=e INTERSTITIAL_ADUNIT_ID=f REWARDED_VIDEO_ADUNIT_ID=g
```

or

```
$ make
```

環境変数を指定しない場合はdefaultのIDが使用されます

## env

| Xcode | Swift | Bundler | CocoaPods |
|:---:|:---:|:---:|:---:|
| 11.4.1 | 5.2 | 2.1.4 | 1.9.0 |

| Google Mobile Ads SDK | FluctSDK |
|:---:|:---:|
| 7.57.0 | 6.4.1 |

| 環境変数 | desc | 備考 |
|:---:|:---:|:----|
| ADMOB_APP_ID | AdMobのアプリのID | AppIDとAdUnitIDはセットで必須 |
| BANNER_ADUNIT_ID | 320x50のバナー | |
| LARGE_BANNER_ADUNIT_ID | 320x100のバナー | |
| MEDIUM_RECTANGLE_ADUNIT_ID | 300x250のバナー | |
| ADAPTIVE_BANNER_ADUNIT_ID | アダプティブバナー | |
| INTERSTITIAL_ADUNIT_ID | インタースティシャル | |
| REWARDED_VIDEO_ADUNIT_ID | 動画リワード | |