import 'package:flutter/material.dart';

class TutorDashboard extends StatefulWidget {
  const TutorDashboard({super.key});

  @override
  State<TutorDashboard> createState() => _TutorDashboardState();
}

class _TutorDashboardState extends State<TutorDashboard> {
  final String tutorName = "Dr. Johnson"; // This would come from your user data

  // List of dashboard items
  final List<DashboardItem> _dashboardItems = [
    DashboardItem(
      title: "My Courses",
      description: "Manage your micro-courses",
      icon: Icons.book,
      color: Colors.teal,
      route: '/tutor-courses',
    ),
    DashboardItem(
      title: "Create Course",
      description: "Add a new micro-course",
      icon: Icons.add_circle,
      color: Colors.blue,
      route: '/create-course',
    ),
    DashboardItem(
      title: "AI Tools",
      description: "Generate summaries & flashcards",
      icon: Icons.auto_awesome,
      color: Colors.purple,
      route: '/ai-tools',
    ),
    DashboardItem(
      title: "Q&A Wall",
      description: "Respond to student questions",
      icon: Icons.question_answer,
      color: Colors.amber.shade700,
      route: '/qa-wall',
    ),
    DashboardItem(
      title: "Analytics",
      description: "View course performance",
      icon: Icons.analytics,
      color: Colors.green,
      route: '/analytics',
    ),
    DashboardItem(
      title: "Settings",
      description: "Update profile, preferences",
      icon: Icons.settings,
      color: Colors.blueGrey,
      route: '/settings',
    ),
  ];

  // Sample micro-courses data
  final List<MicroCourse> _microCourses = [
    MicroCourse(
      id: "1",
      title: "Python Basics",
      description: "Learn Python basics in bite-sized lessons",
      enrolledStudents: 45,
      lessonsCount: 8,
      completionRate: 0.72,
      questionsCount: 12,
    ),
    MicroCourse(
      id: "2",
      title: "Web Development Fundamentals",
      description: "HTML, CSS and JavaScript essentials",
      enrolledStudents: 38,
      lessonsCount: 10,
      completionRate: 0.65,
      questionsCount: 24,
    ),
    MicroCourse(
      id: "3",
      title: "Data Science Basics",
      description: "Introduction to data analysis and visualization",
      enrolledStudents: 27,
      lessonsCount: 6,
      completionRate: 0.48,
      questionsCount: 9,
    ),
  ];

  // Recent activity data
  final List<ActivityItem> _recentActivities = [
    ActivityItem(
      title: "New student enrolled in 'Python Basics'",
      time: "10 minutes ago",
      icon: Icons.person_add,
      color: Colors.blue,
    ),
    ActivityItem(
      title: "AI generated 15 flashcards for 'Web Development Fundamentals'",
      time: "1 hour ago",
      icon: Icons.auto_awesome,
      color: Colors.purple,
    ),
    ActivityItem(
      title: "New question in Q&A Wall for 'Data Science Basics'",
      time: "3 hours ago",
      icon: Icons.question_answer,
      color: Colors.amber.shade700,
    ),
    ActivityItem(
      title: "Added new lesson to 'Python Basics'",
      time: "Yesterday",
      icon: Icons.add_circle,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Tutor Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.teal.shade800,
                      Colors.teal.shade600,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              // Notifications
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Handle notifications
                },
              ),
              // Profile menu
              PopupMenuButton<String>(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.teal),
                ),
                offset: const Offset(0, 50),
                onSelected: (value) {
                  // Handle menu item selection
                  if (value == 'logout') {
                    // Handle logout
                    Navigator.pushReplacementNamed(context, '/welcome');
                  } else if (value == 'profile') {
                    // Navigate to profile
                    Navigator.pushNamed(context, '/profile');
                  } else if (value == 'settings') {
                    // Navigate to settings
                    Navigator.pushNamed(context, '/settings');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.teal),
                          SizedBox(width: 8),
                          Text('Profile'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: Colors.teal),
                          SizedBox(width: 8),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.teal),
                          SizedBox(width: 8),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ];
                },
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Greeting
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $tutorName!",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create engaging micro-courses and empower your students.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats summary
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        "Courses",
                        "3",
                        Icons.book,
                        Colors.teal,
                      ),
                      _buildStatItem(
                        "Students",
                        "110",
                        Icons.people,
                        Colors.blue,
                      ),
                      _buildStatItem(
                        "Questions",
                        "45",
                        Icons.question_answer,
                        Colors.amber.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Dashboard grid
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildDashboardItem(_dashboardItems[index]);
                },
                childCount: _dashboardItems.length,
              ),
            ),
          ),

          // My Micro-Courses
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Micro-Courses",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Navigate to create course
                          Navigator.pushNamed(context, '/create-course');
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text("Create New"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._microCourses.map((course) => _buildCourseItem(course)),
                ],
              ),
            ),
          ),

          // Recent activity
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: _recentActivities
                            .map((activity) => _buildActivityItem(activity))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Q&A Wall',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation
          if (index == 1) {
            Navigator.pushNamed(context, '/tutor-courses');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/qa-wall');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create course
          Navigator.pushNamed(context, '/create-course');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboardItem(DashboardItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the corresponding screen
          Navigator.pushNamed(context, item.route);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 32,
                  color: item.color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseItem(MicroCourse course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.book,
                    color: Colors.teal,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    // Handle menu item selection
                    if (value == 'edit') {
                      Navigator.pushNamed(
                        context,
                        '/edit-course',
                        arguments: course.id,
                      );
                    } else if (value == 'add_lesson') {
                      Navigator.pushNamed(
                        context,
                        '/add-lesson',
                        arguments: course.id,
                      );
                    } else if (value == 'ai_generate') {
                      Navigator.pushNamed(
                        context,
                        '/ai-tools',
                        arguments: course.id,
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit Course'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'add_lesson',
                        child: Text('Add Lesson'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'ai_generate',
                        child: Text('Generate AI Content'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete Course'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCourseStat(
                  Icons.people,
                  "${course.enrolledStudents} Students",
                  Colors.blue,
                ),
                _buildCourseStat(
                  Icons.library_books,
                  "${course.lessonsCount} Lessons",
                  Colors.purple,
                ),
                _buildCourseStat(
                  Icons.question_answer,
                  "${course.questionsCount} Questions",
                  Colors.amber.shade700,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Completion Rate",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${(course.completionRate * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getCompletionColor(course.completionRate),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: course.completionRate,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getCompletionColor(course.completionRate),
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // View course details
                      Navigator.pushNamed(
                        context,
                        '/course-details',
                        arguments: course.id,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.teal,
                    ),
                    child: const Text("View Details"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Manage course
                      Navigator.pushNamed(
                        context,
                        '/manage-course',
                        arguments: course.id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text("Manage"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Color _getCompletionColor(double rate) {
    if (rate < 0.3) return Colors.red;
    if (rate < 0.7) return Colors.amber.shade700;
    return Colors.green;
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity.icon,
              color: activity.color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  activity.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dashboard item model
class DashboardItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  DashboardItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}

// Micro-Course model
class MicroCourse {
  final String id;
  final String title;
  final String description;
  final int enrolledStudents;
  final int lessonsCount;
  final double completionRate;
  final int questionsCount;

  MicroCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.enrolledStudents,
    required this.lessonsCount,
    required this.completionRate,
    required this.questionsCount,
  });
}

// Activity Item model
class ActivityItem {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  ActivityItem({
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
  });
}
