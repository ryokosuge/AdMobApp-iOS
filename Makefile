# AdMob AppID
ADMOB_APP_ID?=ca-app-pub-3010029359415397~5308814924

# AdUnitID
BANNER_ADUNIT_ID?=ca-app-pub-3010029359415397/5019479810
LARGE_BANNER_ADUNIT_ID?=ca-app-pub-3010029359415397/3514826458
MEDIUM_RECTANGLE_ADUNIT_ID?=ca-app-pub-3010029359415397/3323254764
ADAPTIVE_BANNER_ADUNIT_ID?=ca-app-pub-3010029359415397/8384009756
INTERSTITIAL_ADUNIT_ID?=ca-app-pub-3010029359415397/8192438063
REWARDED_VIDEO_ADUNIT_ID?=ca-app-pub-3010029359415397/9313948042

.PHONY: vendor/bundle AdMobApp.xcworkspace AdMobApp/Info.plist AdMobApp/Consts.swift

all: deps vendor/bundle AdMobApp.xcworkspace AdMobApp/Info.plist AdMobApp/Consts.swift

deps:
	gem install bundler:2.1.4

vendor/bundle:
	bundle install --path vendor/bundle

AdMobApp.xcworkspace: vendor/bundle
	bundle exec pod install --repo-update

AdMobApp/Info.plist:
	sed -e "s@###ADMOB_APP_ID###@${ADMOB_APP_ID}@g" AdMobApp/Info.plist.template > AdMobApp/Info.plist

AdMobApp/Consts.swift:
	sed -e "s@###BANNER_ADUNIT_ID###@${BANNER_ADUNIT_ID}@g" \
		-e "s@###LARGE_BANNER_ADUNIT_ID###@${LARGE_BANNER_ADUNIT_ID}@g" \
		-e "s@###MEDIUM_RECTANGLE_ADUNIT_ID###@${MEDIUM_RECTANGLE_ADUNIT_ID}@g" \
		-e "s@###ADAPTIVE_BANNER_ADUNIT_ID###@${ADAPTIVE_BANNER_ADUNIT_ID}@g" \
		-e "s@###INTERSTITIAL_ADUNIT_ID###@${INTERSTITIAL_ADUNIT_ID}@g" \
		-e "s@###REWARDED_VIDEO_ADUNIT_ID###@${REWARDED_VIDEO_ADUNIT_ID}@g" \
		AdMobApp/Consts.swift.template > AdMobApp/Consts.swift

