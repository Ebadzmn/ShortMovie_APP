import 'package:get/get.dart';
import '../Model/rewards_model.dart';
import '../Vip_games/Modet/vip_model.dart';

class RewardsController extends GetxController {
  // Tab State
  final RxBool isRewardsTab = true.obs;
  final RxInt vipTabIndex = 0.obs;

  void toggleTab(bool isRewards) {
    isRewardsTab.value = isRewards;
  }

  void changeVipTab(int index) {
    vipTabIndex.value = index;
  }

  // VIP Pass Data
  final RxList<VipPassModel> vipBenefits = <VipPassModel>[
    VipPassModel(title: "1-Day VIP Pass", gems: "300"),
    VipPassModel(title: "Vote Drop", gems: "300"),
    VipPassModel(title: "Interactive Choice Pass", gems: "300"),
    VipPassModel(title: "3-Day VIP Pass", gems: "300"),
    VipPassModel(title: "Interactive Choice Pass", gems: "300"),
  ].obs;

  final RxList<VipPassModel> redemptionPasses = <VipPassModel>[
    VipPassModel(title: "Redeem Coins", gems: "500"),
    VipPassModel(title: "Unlock Episode", gems: "200"),
    VipPassModel(title: "VIP Avatar", gems: "1000"),
    VipPassModel(title: "Exclusive Theme", gems: "800"),
  ].obs;

  // Data using models
  final RxList<RewardStepModel> rewardsSteps = <RewardStepModel>[
    RewardStepModel(coins: "+10", time: "5mins"),
    RewardStepModel(coins: "+15", time: "10mins"),
    RewardStepModel(coins: "+20", time: "20mins"),
    RewardStepModel(coins: "+25", time: "30mins"),
    RewardStepModel(coins: "+30", time: "40mins"),
  ].obs;

  final RxList<BenefitTaskModel> todayBenefits = <BenefitTaskModel>[
    BenefitTaskModel(
      layoutType: "subtitle_coins",
      title: "Check-in",
      subtitle: "Check-in streak 7 days ",
      coinsLabel: "+540",
      buttonText: "Go",
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Watch Adds(0/12) Get 10 Coins",
      titleSuffix: " at most",
      coinsLabel: "120",
      buttonText: "Watch",
      steps: [
        RewardStepModel(coins: "+10", time: "Add.1"),
        RewardStepModel(coins: "+15", time: "Add.2"),
        RewardStepModel(coins: "+20", time: "Add.3"),
        RewardStepModel(coins: "+25", time: "Add.4"),
        RewardStepModel(coins: "+30", time: "Add.5"),
      ],
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Turn On Notifications",
      coinsLabel: "30",
      buttonText: "Go",
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Watch Ads, Earn Bonus",
      coinsLabel: "10",
      buttonText: "Go",
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Login Rewards",
      coinsLabel: "50",
      buttonText: "Claim",
      isHighlight: true,
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Bind Email",
      coinsLabel: "30",
      buttonText: "Go",
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Follow us on Facebook",
      coinsLabel: "20",
      buttonText: "Go",
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Watch fresh dramas?",
      coinsLabel: "100",
      buttonText: "Watch",
      steps: [
        RewardStepModel(coins: "+10", time: "1mins"),
        RewardStepModel(coins: "+15", time: "2mins"),
        RewardStepModel(coins: "+20", time: "5mins"),
        RewardStepModel(coins: "+25", time: "8mins"),
        RewardStepModel(coins: "+30", time: "10mins"),
      ],
    ),
    BenefitTaskModel(
      layoutType: "top_coins",
      title: "Follow us on Instragram",
      coinsLabel: "20",
      buttonText: "Go",
    ),
  ].obs;

  final RxList<String> descriptions = <String>[
    "1. All interpretation rights of bonus belong to Shortmax.",
    "2. Bonus can only be used to watch dramas, valid for 5 days, and will be automatically expired and liquidated after expiration.",
    "3. Gold coins will be used first when watching dramas, If not enough, Bonus will be used automatically.",
  ].obs;
}
