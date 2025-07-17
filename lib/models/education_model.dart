class Education {
  final String year;
  final String degree;
  final String school;

  Education({required this.year, required this.degree, required this.school});
}

final List<Education> educationList = [
  Education(year: "2023 - Present", degree: "ADSE Diploma", school: "Aptech"),
  Education(year: "2021 - 2023", degree: "HSC", school: "Superior Government College"),
  Education(year: "2020 - 2021", degree: "SSC", school: "MJM School"),
];
