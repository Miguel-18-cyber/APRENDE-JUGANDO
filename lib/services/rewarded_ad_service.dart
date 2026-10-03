import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdService extends ChangeNotifier {
  RewardedAdService._();

  static final RewardedAdService instance = RewardedAdService._();

  static const _productionAdUnitId =
      'ca-app-pub-3934791251127084/4064553809';
  static const _testAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  RewardedAd? _ad;
  bool _isLoading = false;
  bool _isPreparing = false;
  bool _sdkInitialized = false;
  bool _rewardedThisSession = false;
  Future<void>? _initialization;

  bool get isSupported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  bool get isAdReady => _ad != null;
  bool get isLoading => _isLoading || _isPreparing;
  bool get rewardedThisSession => _rewardedThisSession;

  Future<void> initialize() => _initialization ??= _initialize();

  void retry() {
    if (_sdkInitialized) {
      loadAd();
      return;
    }
    _initialization = null;
    unawaited(initialize());
  }

  Future<void> _initialize() async {
    if (!isSupported) return;

    _isPreparing = true;
    notifyListeners();
    try {
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
          maxAdContentRating: MaxAdContentRating.g,
        ),
      );
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(tagForUnderAgeOfConsent: true),
        _loadConsentForm,
        (error) {
          debugPrint('No se pudo actualizar el consentimiento UMP: $error');
          unawaited(_initializeAdsIfAllowed());
        },
      );
    } catch (error) {
      _isPreparing = false;
      notifyListeners();
      debugPrint('No se pudo iniciar AdMob: $error');
    }
  }

  void _loadConsentForm() {
    ConsentForm.loadAndShowConsentFormIfRequired((error) {
      if (error != null) {
        debugPrint('No se pudo mostrar el formulario UMP: $error');
      }
      unawaited(_initializeAdsIfAllowed());
    });
  }

  Future<void> _initializeAdsIfAllowed() async {
    if (_sdkInitialized) return;
    try {
      if (!await ConsentInformation.instance.canRequestAds()) {
        _isPreparing = false;
        notifyListeners();
        return;
      }
      await MobileAds.instance.initialize();
      _sdkInitialized = true;
      _isPreparing = false;
      notifyListeners();
      loadAd();
    } catch (error) {
      _isPreparing = false;
      notifyListeners();
      debugPrint('No se pudo iniciar AdMob tras UMP: $error');
    }
  }

  void loadAd() {
    if (!isSupported || !_sdkInitialized || _isLoading || _ad != null) return;
    _isLoading = true;
    notifyListeners();

    RewardedAd.load(
      adUnitId: kReleaseMode ? _productionAdUnitId : _testAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('No se pudo cargar el video bonificado: $error');
          notifyListeners();
        },
      ),
    );
  }

  bool showAd({required VoidCallback onRewardEarned}) {
    final ad = _ad;
    if (ad == null || !isSupported || _rewardedThisSession) return false;

    _ad = null;
    _rewardedThisSession = true;
    notifyListeners();
    var rewardDelivered = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('No se pudo mostrar el video bonificado: $error');
        ad.dispose();
        loadAd();
      },
    );
    ad.show(
      onUserEarnedReward: (_, reward) {
        if (rewardDelivered) return;
        rewardDelivered = true;
        onRewardEarned();
      },
    );
    return true;
  }
}
