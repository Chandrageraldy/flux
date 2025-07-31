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
  Widget body() {
    return AutoTabsRouter.tabBar(
      physics: NeverScrollableScrollPhysics(),
      routes: const [
        ProgressRoute(),
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
          bottomNavigationBar: Container(
            decoration: BoxDecoration(borderRadius: AppStyles.kRadOTL20TR20),
            child: ClipRRect(
              borderRadius: AppStyles.kRadOTL20TR20,
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
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: context.theme.colorScheme.onTertiary,
                  unselectedItemColor: context.theme.colorScheme.tertiaryFixed,
                  selectedLabelStyle: Quicksand.bold.withSize(FontSizes.extraSmall),
                  unselectedLabelStyle: Quicksand.bold.withSize(FontSizes.extraSmall),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    getProgressBarItem(),
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

  @override
  bool hasDefaultPadding() {
    return false;
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _DashboardPageState {
  BottomNavigationBarItem getProgressBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.chartLine, size: AppStyles.kSize20),
      activeIcon: FaIcon(FontAwesomeIcons.chartLine, color: context.theme.colorScheme.primary, size: AppStyles.kSize20),
      label: S.current.progressLabel,
    );
  }

  BottomNavigationBarItem getDiaryBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.bookOpenReader, size: AppStyles.kSize20),
      activeIcon:
          FaIcon(FontAwesomeIcons.bookOpenReader, color: context.theme.colorScheme.primary, size: AppStyles.kSize20),
      label: S.current.diaryLabel,
    );
  }

  BottomNavigationBarItem getLogFoodBarItem() {
    final navigationItem = Container(
      padding: AppStyles.kPaddSV6H8,
      decoration: BoxDecoration(
        borderRadius: AppStyles.kRad100,
        color: context.theme.colorScheme.secondary,
      ),
      child: FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize20),
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
          FaIcon(FontAwesomeIcons.appleWhole, color: context.theme.colorScheme.primary, size: AppStyles.kSize20),
      label: S.current.foodLabel,
    );
  }

  BottomNavigationBarItem getMoreBarItem() {
    return BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.solidUser, size: AppStyles.kSize20),
      activeIcon: FaIcon(FontAwesomeIcons.solidUser, color: context.theme.colorScheme.primary, size: AppStyles.kSize20),
      label: S.current.profileLabel,
    );
  }
}
