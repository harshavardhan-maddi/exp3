import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveUIDemo());
}

class ResponsiveUIDemo extends StatelessWidget {
  const ResponsiveUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
    );
  }
}

String getScreenCategory(double width) {
  if (width < 600) {
    return 'Mobile';
  } else if (width < 1024) {
    return 'Tablet';
  } else {
    return 'Desktop';
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final orientation = mediaQuery.orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Dashboard'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final category = getScreenCategory(constraints.maxWidth);

              return Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const Text(
                          'Responsive Flutter UI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$category ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Width: ${width.toStringAsFixed(0)} | '
                          'Height: ${height.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _buildLayout(
                        context,
                        constraints.maxWidth,
                        orientation,
                      ),
                    ),
                  ),

                  // Footer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    color: Colors.grey.shade200,
                    child: Text(
                      'Active Layout: $category',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    double width,
    Orientation orientation,
  ) {
    // MOBILE
    if (width < 600) {
      return Column(
        children: [
          Expanded(
            child: _dashboardCard(
              Icons.phone_android,
              'Mobile Card',
              'Single column layout',
              Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _dashboardCard(
              Icons.screen_rotation,
              orientation == Orientation.portrait
                  ? 'Portrait Mode'
                  : 'Landscape Mode',
              'Layout changes with orientation',
              Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _dashboardCard(
              Icons.devices,
              'Responsive',
              'Adapts to screen size',
              Colors.orange,
            ),
          ),
        ],
      );
    }

    // TABLET
    if (width < 1024) {
      return Row(
        children: [
          Expanded(
            child: _dashboardCard(
              Icons.tablet,
              'Tablet Card 1',
              'Two column layout',
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _dashboardCard(
              Icons.dashboard,
              'Tablet Card 2',
              'Flexible width',
              Colors.green,
            ),
          ),
        ],
      );
    }

    // DESKTOP
    return Row(
      children: [
        // Navigation Rail
        NavigationRail(
          selectedIndex: 0,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.analytics),
              label: Text('Analytics'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),

        const SizedBox(width: 16),

        // Three column layout
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: _dashboardCard(
                  Icons.home,
                  'Column 1',
                  'Desktop content',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 1,
                child: _dashboardCard(
                  Icons.analytics,
                  'Column 2',
                  'Flexible layout',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 1,
                child: _dashboardCard(
                  Icons.settings,
                  'Column 3',
                  'Responsive design',
                  Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dashboardCard(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: color,
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}e