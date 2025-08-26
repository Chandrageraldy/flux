import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class DashboardPage extends BaseStatefulPage {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseStatefulState<DashboardPage> {
  @override
  bool bottomSafeAreaEnabled() => false;

  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    return AutoTabsRouter.tabBar(
      physics: NeverScrollableScrollPhysics(),
      routes: const [
        OverviewRoute(),
        DiaryRoute(),
        LoggingSelectionRoute(),
        FoodSearchRoute(),
        ProfileRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          extendBody: true,
          floatingActionButton: tabsRouter.activeIndex == 3
              ? FloatingActionButton(
                  onPressed: () {
                    context.router.push(ChiaChatbotNavigatorRoute(children: [ChiaChatbotLoadingRoute()]));
                  },
                  backgroundColor: context.theme.colorScheme.secondary,
                  mini: true,
                  child: Image.asset(ImagePath.aiStar, height: AppStyles.kSize26, width: AppStyles.kSize26),
                )
              : null,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: AppStyles.kRadOTL15TR15,
              boxShadow: [
                BoxShadow(
                  color: context.theme.colorScheme.tertiaryFixedDim,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: AppStyles.kRadOTL15TR15,
              child: Container(
                color: context.theme.colorScheme.onPrimary,
                child: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (index) {
                    if (index == 2) {
                      context.router.push(LoggingSelectionRoute());
                    } else {
                      tabsRouter.setActiveIndex(index);
                    }
                  },
                  backgroundColor: AppColors.transparentColor,
                  elevation: 0,
                  selectedItemColor: context.theme.colorScheme.onTertiary,
                  unselectedItemColor: context.theme.colorScheme.tertiaryFixed,
                  selectedLabelStyle: Quicksand.bold.withSize(FontSizes.extraSmall),
                  unselectedLabelStyle: Quicksand.bold.withSize(FontSizes.extraSmall),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    getOverviewBarItem(),
                    getDiaryBarItem(),
                    getLogFoodBarItem(),
                    getFoodBarItem(),
                    getMoreBarItem(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _DashboardPageState {
  BottomNavigationBarItem getOverviewBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.compass, size: AppStyles.kSize20),
      activeIcon: FaIcon(FontAwesomeIcons.compass, color: context.theme.colorScheme.secondary, size: AppStyles.kSize20),
      label: S.current.overviewLabel,
    );
  }

  BottomNavigationBarItem getDiaryBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.bookOpenReader, size: AppStyles.kSize20),
      activeIcon:
          FaIcon(FontAwesomeIcons.bookOpenReader, color: context.theme.colorScheme.secondary, size: AppStyles.kSize20),
      label: S.current.diaryLabel,
    );
  }

  BottomNavigationBarItem getLogFoodBarItem() {
    final navigationItem = Container(
      padding: AppStyles.kPadd6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.colorScheme.secondary.withAlpha(60),
      ),
      child: Container(
        padding: AppStyles.kPadd6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.colorScheme.secondary,
        ),
        child: FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize14),
      ),
    );

    return BottomNavigationBarItem(
      icon: Transform.translate(
        offset: const Offset(0, 6),
        child: navigationItem,
      ),
      activeIcon: Transform.translate(
        offset: const Offset(0, 6),
        child: navigationItem,
      ),
      label: '', // still required
    );
  }

  BottomNavigationBarItem getFoodBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.appleWhole, size: AppStyles.kSize20),
      activeIcon:
          FaIcon(FontAwesomeIcons.appleWhole, color: context.theme.colorScheme.secondary, size: AppStyles.kSize20),
      label: S.current.foodLabel,
    );
  }

  BottomNavigationBarItem getMoreBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.solidUser, size: AppStyles.kSize20),
      activeIcon:
          FaIcon(FontAwesomeIcons.solidUser, color: context.theme.colorScheme.secondary, size: AppStyles.kSize20),
      label: S.current.profileLabel,
    );
  }
}
