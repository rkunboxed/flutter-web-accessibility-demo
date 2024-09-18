import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:web_accessibility_demo/page_one.dart';
import 'package:web_accessibility_demo/page_two.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      title: 'Accessibility Demo',
      //showSemanticsDebugger: true,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PageController _pageViewController;
  double? _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController(initialPage: 0)..addListener(_handlePageChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10), () {
        SemanticsService.announce('Good Afternoon', TextDirection.ltr);
      });
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _pageViewController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextButton(
              onPressed: (_currentPage ?? 0) > 0
                  ? () {
                      _pageViewController.animateToPage(
                        _currentPage == null ? 0 : (_currentPage!.round() - 1),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('previous'),
            ),
            TextButton(
              onPressed: (_currentPage ?? 0) < 1
                  ? () {
                      _pageViewController.animateToPage(
                        _currentPage == null ? 0 : (_currentPage!.round() + 1),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('next'),
            )
          ],
        ),
      ),
      body: Semantics(
        label: 'examples',
        explicitChildNodes: true,
        child: Center(
          child: PageView(
            controller: _pageViewController,
            children: const [
              PageOne(),
              PageTwo(),
            ],
          ),
        ),
      ),
    );
  }
}
