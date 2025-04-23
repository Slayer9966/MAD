import 'package:flutter/material.dart';

class CourseCatalog extends StatefulWidget {
  const CourseCatalog({super.key});

  @override
  State<CourseCatalog> createState() => _CourseCatalogState();
}

class _CourseCatalogState extends State<CourseCatalog> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All";
  String _selectedSort = "Popular";

  // Sample course data
  final List<Course> _courses = [
    Course(
      id: "1",
      title: "Python Basics",
      description: "Learn Python basics in bite-sized lessons",
      tutorName: "Dr. Johnson",
      tutorAvatar: "assets/avatars/tutor1.jpg",
      category: "Programming",
      rating: 4.8,
      studentsCount: 1245,
      lessonsCount: 8,
      isEnrolled: false,
    ),
    Course(
      id: "2",
      title: "Web Development Fundamentals",
      description: "HTML, CSS and JavaScript essentials",
      tutorName: "Prof. Smith",
      tutorAvatar: "assets/avatars/tutor2.jpg",
      category: "Web Development",
      rating: 4.6,
      studentsCount: 987,
      lessonsCount: 10,
      isEnrolled: false,
    ),
    Course(
      id: "3",
      title: "Data Science Basics",
      description: "Introduction to data analysis and visualization",
      tutorName: "Dr. Williams",
      tutorAvatar: "assets/avatars/tutor3.jpg",
      category: "Data Science",
      rating: 4.7,
      studentsCount: 756,
      lessonsCount: 6,
      isEnrolled: false,
    ),
    Course(
      id: "4",
      title: "Mobile App Development",
      description: "Build cross-platform mobile apps with Flutter",
      tutorName: "Prof. Davis",
      tutorAvatar: "assets/avatars/tutor4.jpg",
      category: "Mobile Development",
      rating: 4.9,
      studentsCount: 1089,
      lessonsCount: 12,
      isEnrolled: false,
    ),
    Course(
      id: "5",
      title: "Machine Learning Fundamentals",
      description: "Introduction to machine learning algorithms",
      tutorName: "Dr. Brown",
      tutorAvatar: "assets/avatars/tutor5.jpg",
      category: "Data Science",
      rating: 4.5,
      studentsCount: 678,
      lessonsCount: 9,
      isEnrolled: false,
    ),
  ];

  // Categories
  final List<String> _categories = [
    "All",
    "Programming",
    "Web Development",
    "Data Science",
    "Mobile Development",
    "Design",
    "Business",
  ];

  // Sort options
  final List<String> _sortOptions = [
    "Popular",
    "Newest",
    "Highest Rated",
    "Most Students",
  ];

  List<Course> get _filteredCourses {
    return _courses.where((course) {
      // Apply category filter
      if (_selectedCategory != "All" && course.category != _selectedCategory) {
        return false;
      }

      // Apply search filter
      if (_searchController.text.isNotEmpty) {
        final searchTerm = _searchController.text.toLowerCase();
        return course.title.toLowerCase().contains(searchTerm) ||
            course.description.toLowerCase().contains(searchTerm) ||
            course.tutorName.toLowerCase().contains(searchTerm);
      }

      return true;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Catalog"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search courses...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Category filter
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Sort filter
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _sortOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSort = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Course list
          Expanded(
            child: _filteredCourses.isEmpty
                ? const Center(
                    child: Text(
                      "No courses found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCourses.length,
                    itemBuilder: (context, index) {
                      return _buildCourseCard(_filteredCourses[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to course details
          Navigator.pushNamed(
            context,
            '/course-details',
            arguments: course.id,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course header with category badge
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.book,
                      size: 48,
                      color: Colors.indigo.shade300,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        course.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Course content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    course.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tutor info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        course.tutorName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.rating.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Course stats
                  Row(
                    children: [
                      _buildCourseStat(
                        Icons.people,
                        "${course.studentsCount} students",
                      ),
                      const SizedBox(width: 16),
                      _buildCourseStat(
                        Icons.library_books,
                        "${course.lessonsCount} lessons",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Enroll button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _enrollInCourse(course);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        course.isEnrolled ? "Enrolled" : "Enroll Now",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _enrollInCourse(Course course) {
    // Show enrollment confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enroll in Course"),
          content: Text(
            "Are you sure you want to enroll in '${course.title}'?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Update course enrollment status
                setState(() {
                  final index = _courses.indexWhere((c) => c.id == course.id);
                  if (index != -1) {
                    _courses[index] = Course(
                      id: course.id,
                      title: course.title,
                      description: course.description,
                      tutorName: course.tutorName,
                      tutorAvatar: course.tutorAvatar,
                      category: course.category,
                      rating: course.rating,
                      studentsCount: course.studentsCount,
                      lessonsCount: course.lessonsCount,
                      isEnrolled: true,
                    );
                  }
                });

                // Close dialog
                Navigator.of(context).pop();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Successfully enrolled in '${course.title}'"),
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate to enrolled courses
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacementNamed(context, '/student-courses');
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
              child: const Text("Enroll"),
            ),
          ],
        );
      },
    );
  }
}

// Course model
class Course {
  final String id;
  final String title;
  final String description;
  final String tutorName;
  final String tutorAvatar;
  final String category;
  final double rating;
  final int studentsCount;
  final int lessonsCount;
  final bool isEnrolled;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.tutorName,
    required this.tutorAvatar,
    required this.category,
    required this.rating,
    required this.studentsCount,
    required this.lessonsCount,
    required this.isEnrolled,
  });
}
