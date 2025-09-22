import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class MyCourse1Screen extends StatefulWidget {
  const MyCourse1Screen({super.key});

  @override
  State<MyCourse1Screen> createState() => _MyCourse1ScreenState();
}

class _MyCourse1ScreenState extends State<MyCourse1Screen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define base dimensions from Figma (375x812) for scaling
    const double baseWidth = 375;
    const double baseHeight = 812;

    // Helper to scale dimensions proportionally
    double scaleWidth(double value) => value * (screenWidth / baseWidth);
    double scaleHeight(double value) => value * (screenHeight / baseHeight);

    // Common text/icon color based on Figma JSON (r: 0.12156862765550613, g: 0.12156862765550613, b: 0.2235294133424759)
    const Color primaryTextColor = Color(0xFF1F1F39);
    // Common secondary text color (r: 0.5215686559677124, g: 0.5215686559677124, b: 0.5921568870544434)
    const Color secondaryTextColor = Color(0xFF858597);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildStatusBar(screenWidth, scaleWidth, scaleHeight, primaryTextColor),
            _buildNavigationBar(context, screenWidth, scaleWidth, scaleHeight, primaryTextColor),
            SizedBox(height: scaleHeight(12)), // Spacing between nav bar and 'Learned today' card
            _buildLearnedTodayCard(screenWidth, scaleWidth, scaleHeight, primaryTextColor, secondaryTextColor),
            SizedBox(height: scaleHeight(12)), // Spacing between cards
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: scaleWidth(20)),
                child: Column(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                      shrinkWrap: true, // Wrap content to minimum size
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: scaleWidth(14), // Calculated from Figma positions
                        mainAxisSpacing: scaleHeight(14), // Calculated from Figma positions
                        childAspectRatio: scaleWidth(160) / scaleHeight(182.688), // Card dimensions 160x182.688
                      ),
                      itemCount: 3, // Number of course cards shown in the JSON
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildCourseCard(
                            context,
                            title: 'Product\nDesign v1.0',
                            completed: '14/24',
                            cardColor: const Color(0xFFFFF1F6), // r:1, g:0.905, b:0.933
                            progressColor: const Color(0xFFEC7B9C), // r:0.925, g:0.482, b:0.611
                            playButtonColor: const Color(0xFFEC7B9C),
                            primaryTextColor: primaryTextColor,
                            scaleWidth: scaleWidth,
                            scaleHeight: scaleHeight,
                          );
                        } else if (index == 1) {
                          return _buildCourseCard(
                            context,
                            title: 'Visual Design',
                            completed: '10/16',
                            cardColor: const Color(0xFFBADEC8), // r:0.729, g:0.878, b:0.858
                            progressColor: const Color(0xFF398A80), // r:0.223, g:0.541, b:0.501
                            playButtonColor: const Color(0xFF398A80),
                            primaryTextColor: primaryTextColor,
                            scaleWidth: scaleWidth,
                            scaleHeight: scaleHeight,
                          );
                        } else {
                          return _buildCourseCard(
                            context,
                            title: 'Java \nDevelopment',
                            completed: '12/18',
                            cardColor: const Color(0xFFBAD6FF), // r:0.729, g:0.839, b:1
                            progressColor: const Color(0xFF3D5CFF), // r:0.239, g:0.360, b:1
                            playButtonColor: const Color(0xFF3D5CFF),
                            primaryTextColor: primaryTextColor,
                            scaleWidth: scaleWidth,
                            scaleHeight: scaleHeight,
                          );
                        }
                      },
                    ),
                    SizedBox(height: scaleHeight(20)), // Padding at the bottom of the scroll view
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(double screenWidth, double Function(double) scaleWidth,
      double Function(double) scaleHeight, Color textColor) {
    return Container(
      width: screenWidth,
      height: scaleHeight(44),
      padding: EdgeInsets.symmetric(horizontal: scaleWidth(21)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: scaleWidth(15),
              fontWeight: FontWeight.w600, // Poppins-Semibold
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.signal_cellular_alt,
                size: scaleWidth(16),
                color: textColor,
              ),
              SizedBox(width: scaleWidth(5)),
              Icon(
                Icons.wifi,
                size: scaleWidth(16),
                color: textColor,
              ),
              SizedBox(width: scaleWidth(5)),
              Icon(
                Icons.battery_full,
                size: scaleWidth(18),
                color: textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context, double screenWidth,
      double Function(double) scaleWidth, double Function(double) scaleHeight, Color textColor) {
    return Container(
      width: screenWidth,
      height: scaleHeight(44),
      padding: EdgeInsets.symmetric(horizontal: scaleWidth(17)),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: scaleWidth(20), color: textColor),
            onPressed: () {
              context.pop(); // Using go_router for back navigation
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                'My courses',
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: scaleWidth(18),
                  fontWeight: FontWeight.w500, // Poppins-Medium
                ),
              ),
            ),
          ),
          SizedBox(width: scaleWidth(40)), // Placeholder for symmetric alignment if needed
        ],
      ),
    );
  }

  Widget _buildLearnedTodayCard(double screenWidth, double Function(double) scaleWidth,
      double Function(double) scaleHeight, Color primaryTextColor, Color secondaryTextColor) {
    return Container(
      width: scaleWidth(335),
      height: scaleHeight(96),
      margin: EdgeInsets.symmetric(horizontal: scaleWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(scaleWidth(12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8B8D2).withOpacity(0.2), // Figma color `r: 0.721, g: 0.721, b: 0.823, a: 0.2`
            offset: Offset(0, scaleHeight(8)),
            blurRadius: scaleWidth(12),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(scaleWidth(36), scaleHeight(20), scaleWidth(36), scaleHeight(17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learned today',
            style: GoogleFonts.poppins(
              color: secondaryTextColor,
              fontSize: scaleWidth(12),
              fontWeight: FontWeight.w400, // Poppins-Regular
            ),
          ),
          SizedBox(height: scaleHeight(2)), // Difference between 120 and 140 (approx center)
          Row(
            children: [
              Text(
                '46min',
                style: GoogleFonts.poppins(
                  color: primaryTextColor,
                  fontSize: scaleWidth(20),
                  fontWeight: FontWeight.w700, // Poppins-Bold
                ),
              ),
              SizedBox(width: scaleWidth(4)), // Spacing
              Text(
                '/ 60min',
                style: GoogleFonts.poppins(
                  color: secondaryTextColor,
                  fontSize: scaleWidth(10),
                  fontWeight: FontWeight.w400, // Poppins-Regular
                ),
              ),
            ],
          ),
          SizedBox(height: scaleHeight(8)),
          Stack(
            children: [
              Container(
                width: scaleWidth(303),
                height: scaleHeight(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3FD), // Figma color `r: 0.956, g: 0.952, b: 0.992`
                  borderRadius: BorderRadius.circular(scaleHeight(3)),
                ),
              ),
              Container(
                width: scaleWidth(210), // This width is 210 out of 303 total
                height: scaleHeight(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scaleHeight(3)),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(0, 255, 255, 255), // Gradient starts transparent white
                      Color(0xFFFF5106), // Figma color `r:1, g:0.317, b:0.023`
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String title,
    required String completed,
    required Color cardColor,
    required Color progressColor,
    required Color playButtonColor,
    required Color primaryTextColor,
    required double Function(double) scaleWidth,
    required double Function(double) scaleHeight,
  }) {
    return Container(
      width: scaleWidth(160),
      height: scaleHeight(182.688),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(scaleWidth(12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8B8D2).withOpacity(0.2), // Figma color `r: 0.721, g: 0.721, b: 0.823, a: 0.2`
            offset: Offset(0, scaleHeight(8)),
            blurRadius: scaleWidth(12),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        scaleWidth(19), // 40-21=19 for left
        scaleHeight(25), // 241-216=25 for top of title
        scaleWidth(19),
        scaleHeight(19), // Bottom padding approx
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: primaryTextColor,
              fontSize: scaleWidth(16),
              fontWeight: FontWeight.w700, // Poppins-Bold
              height: 1.5, // Line height 24px for 16px font
            ),
          ),
          SizedBox(height: scaleHeight(26.455)), // Space between title and progress bar
          Stack(
            children: [
              Container(
                width: scaleWidth(122), // Rectangle 72 width
                height: scaleHeight(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(scaleHeight(3)),
                ),
              ),
              Container(
                width: scaleWidth(80.859), // Rectangle 73 width
                height: scaleHeight(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scaleHeight(3)),
                  gradient: LinearGradient(
                    colors: [
                      progressColor,
                      progressColor.withOpacity(0.502), // Figma gradient opacity 0.5019999742507935
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: scaleHeight(8.544)), // Space between progress bar and 'Completed' text
          Text(
            'Completed',
            style: GoogleFonts.poppins(
              color: primaryTextColor,
              fontSize: scaleWidth(12),
              fontWeight: FontWeight.w400, // Poppins-Regular
            ),
          ),
          SizedBox(height: scaleHeight(1.544)), // Space between 'Completed' and count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                completed,
                style: GoogleFonts.poppins(
                  color: primaryTextColor,
                  fontSize: scaleWidth(20),
                  fontWeight: FontWeight.w700, // Poppins-Bold
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to course details screen when play button is tapped
                  context.push('/courseDetails'); // Using go_router for navigation
                },
                child: Container(
                  width: scaleWidth(44),
                  height: scaleHeight(44),
                  decoration: BoxDecoration(
                    color: playButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: scaleWidth(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}