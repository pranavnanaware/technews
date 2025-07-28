import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SubscriptionStatus {
  none,
  trial,
  active,
  expired,
  cancelled,
}

class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String period;
  final String? discount;
  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.period,
    this.discount,
    this.isPopular = false,
  });
}

class SubscriptionProvider extends ChangeNotifier {
  static const String _trialStartKey = 'trial_start_date';
  static const String _hasUsedTrialKey = 'has_used_trial';
  
  SubscriptionStatus _status = SubscriptionStatus.none;
  bool _isLoading = false;
  String? _errorMessage;
  CustomerInfo? _customerInfo;
  List<Package> _availablePackages = [];
  DateTime? _trialEndDate;
  bool _hasUsedTrial = false;

  // Subscription plans
  final List<SubscriptionPlan> _plans = [
    const SubscriptionPlan(
      id: 'monthly',
      title: 'Monthly',
      price: '\$9.99',
      period: 'per month',
    ),
    const SubscriptionPlan(
      id: 'annual',
      title: 'Annual',
      price: '\$59.99',
      period: 'per year',
      discount: 'Save 50%',
      isPopular: true,
    ),
  ];

  // Getters
  SubscriptionStatus get status => _status;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CustomerInfo? get customerInfo => _customerInfo;
  List<Package> get availablePackages => _availablePackages;
  List<SubscriptionPlan> get plans => _plans;
  DateTime? get trialEndDate => _trialEndDate;
  bool get hasUsedTrial => _hasUsedTrial;
  bool get isInTrial => _status == SubscriptionStatus.trial;
  bool get hasActiveSubscription => 
      _status == SubscriptionStatus.active || _status == SubscriptionStatus.trial;

  int get trialDaysRemaining {
    if (_trialEndDate == null || _status != SubscriptionStatus.trial) {
      return 0;
    }
    final remaining = _trialEndDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  SubscriptionProvider() {
    _initializeSubscriptions();
  }

  Future<void> _initializeSubscriptions() async {
    _setLoading(true);
    
    try {
      // Initialize RevenueCat
      await Purchases.configure(
        PurchasesConfiguration(
          'your_revenuecat_api_key', // Replace with your actual API key
        ),
      );
      
      await _loadTrialState();
      await _refreshCustomerInfo();
      await _loadAvailablePackages();
      
    } catch (e) {
      _setError('Failed to initialize subscriptions: ${e.toString()}');
    }
    
    _setLoading(false);
  }

  Future<void> _loadTrialState() async {
    final prefs = await SharedPreferences.getInstance();
    _hasUsedTrial = prefs.getBool(_hasUsedTrialKey) ?? false;
    
    final trialStartMillis = prefs.getInt(_trialStartKey);
    if (trialStartMillis != null) {
      final trialStart = DateTime.fromMillisecondsSinceEpoch(trialStartMillis);
      _trialEndDate = trialStart.add(const Duration(days: 3));
      
      if (DateTime.now().isBefore(_trialEndDate!)) {
        _status = SubscriptionStatus.trial;
      } else {
        _status = SubscriptionStatus.expired;
      }
    }
  }

  Future<void> _refreshCustomerInfo() async {
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      _updateSubscriptionStatus();
    } catch (e) {
      debugPrint('Failed to refresh customer info: $e');
    }
  }

  Future<void> _loadAvailablePackages() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        _availablePackages = offerings.current!.availablePackages;
      }
    } catch (e) {
      debugPrint('Failed to load packages: $e');
    }
  }

  void _updateSubscriptionStatus() {
    if (_customerInfo?.entitlements.active.isNotEmpty == true) {
      _status = SubscriptionStatus.active;
    } else if (_status == SubscriptionStatus.trial) {
      // Keep trial status if still in trial period
      return;
    } else {
      _status = SubscriptionStatus.none;
    }
    notifyListeners();
  }

  Future<bool> startFreeTrial() async {
    if (_hasUsedTrial) {
      _setError('Free trial has already been used');
      return false;
    }

    try {
      _setLoading(true);
      _setError(null);

      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      
      await prefs.setInt(_trialStartKey, now.millisecondsSinceEpoch);
      await prefs.setBool(_hasUsedTrialKey, true);
      
      _hasUsedTrial = true;
      _trialEndDate = now.add(const Duration(days: 3));
      _status = SubscriptionStatus.trial;
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to start free trial: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      _setLoading(true);
      _setError(null);

      final customerInfo = await Purchases.purchasePackage(package);
      _customerInfo = customerInfo;
      _updateSubscriptionStatus();
      
      _setLoading(false);
      return true;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        _setError(null); // User cancelled, don't show error
      } else {
        _setError('Purchase failed: ${e.message}');
      }
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Purchase failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    try {
      _setLoading(true);
      _setError(null);

      final customerInfo = await Purchases.restorePurchases();
      _customerInfo = customerInfo;
      _updateSubscriptionStatus();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to restore purchases: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Package? getPackageById(String packageId) {
    try {
      return _availablePackages.firstWhere(
        (package) => package.identifier == packageId,
      );
    } catch (e) {
      return null;
    }
  }

  String getFormattedPrice(Package package) {
    return package.storeProduct.priceString;
  }

  String getTrialStatusText() {
    if (_status == SubscriptionStatus.trial) {
      final daysRemaining = trialDaysRemaining;
      if (daysRemaining > 0) {
        return '$daysRemaining day${daysRemaining == 1 ? '' : 's'} left in trial';
      } else {
        return 'Trial expired';
      }
    }
    return '';
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    await _refreshCustomerInfo();
    await _loadAvailablePackages();
  }
}