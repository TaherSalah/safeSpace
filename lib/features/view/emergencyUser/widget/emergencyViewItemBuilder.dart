import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';

class EmergencyViewItemBuilder extends StatefulWidget {
  const EmergencyViewItemBuilder({super.key});

  @override
  State<EmergencyViewItemBuilder> createState() =>
      _EmergencyViewItemBuilderState();
}

class _EmergencyViewItemBuilderState extends State<EmergencyViewItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Welcome back, ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20.sp), // Default text style
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sarina!',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          CardItemBuilderWidget(
              title: "Ai assistant",
              onTap: () {
                Navigator.pushNamed(context, Routes.chatRoute);
              },
              iconPath: "assets/images/Meetup Icon.png"),
          CardItemBuilderWidget(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GuidelinesScreen(),)) ;             },
              title: "Panic attack guidelines",
              iconPath: "assets/images/BookOpen.png"),
        ],
      ),
    );
  }
}

class CardItemBuilderWidget extends StatelessWidget {
  const CardItemBuilderWidget(
      {super.key, required this.title, required this.iconPath, this.onTap});
  final String title, iconPath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Color(0xffEF5DA8)),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: TextDefaultWidget(
                  title: title,
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 55,
                  width: 60,
                  child: Image.asset(
                    iconPath,
                    color: Color(0xffFFD0Df),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class GuidelinesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> guidelines = [
    {
      "title": "1. Stay Calm",
      "points": [
        "Your calm demeanor can help reassure the person.",
        "Take deep breaths to maintain your composure.",
      ]
    },
    {
      "title": "2. Acknowledge Their Feelings",
      "points": [
        "Let them know that you understand they are feeling scared or overwhelmed.",
        "\"I’m here for you.\"",
        "\"It's okay to feel this way.\"",
      ]
    },
    {
      "title": "3. Encourage Deep Breathing",
      "points": [
        "Help them focus on their breathing.",
        "\"Let’s breathe in deeply through our noses, hold for a moment, and then breathe out slowly.\"",
      ]
    },
    {
      "title": "4. Use Grounding Techniques",
      "points": [
        "Encourage them to focus on their surroundings. Ask them to identify:",
        "Five things they can see",
        "Four things they can touch",
        "Three things they can hear",
        "Two things they can smell",
      ]
    },
    {
      "title": "5. Stay with Them",
      "points": [
        "Remain by their side until they feel better.",
        "Your presence can provide comfort and security.",
      ]
    },
    {
      "title": "6. Avoid Dismissing Their Experience",
      "points": [
        "Don’t tell them to \"calm down\" or \"just relax.\"",
        "Validate their feelings and let them know it's okay to feel this way.",
      ]
    },
    {
      "title": "7. Provide Reassurance",
      "points": [
        "Remind them that panic attacks are temporary, and they will pass.",
        "Encourage them to focus on the present moment.",
      ]
    },
  ];

   GuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panic Attack Guidelines'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: guidelines.length,
        itemBuilder: (context, index) {
          final item = guidelines[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...item['points'].map<Widget>((point) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "- $point",
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
