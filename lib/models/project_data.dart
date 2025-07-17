import 'project_model.dart';

final List<Project> projects = [
  Project(
    id: 1,
    title: 'Recipe Explorer',
    category: 'Website',
    imageUrl: 'https://via.placeholder.com/400x300/FF6347/FFFFFF?text=Recipe+Explorer',
    description: 'Responsive recipe site with filters and user submissions.',
    technologies: ['HTML', 'CSS', 'JavaScript', 'Bootstrap'],
    github: 'https://github.com/Muhammadd-01/Recipe_App.git',
    live: 'https://recipe-app-two-weld.vercel.app',
  ),
  Project(
    id: 2,
    title: 'To-Do List App',
    category: 'Website',
    imageUrl: 'assets/todo.png',
    description: 'Sleek UI to-do app with filtering and local storage.',
    technologies: ['React', 'Local Storage', 'Tailwind CSS'],
    github: 'https://github.com/Muhammadd-01/To-Do_App.git',
    live: 'https://to-do-app-silk-nu.vercel.app',
  ),
  // Add more...
];
