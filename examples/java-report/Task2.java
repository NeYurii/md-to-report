public class Task2 {
        public static void main(String[] args)
        {
                Student[] students = {
                        new Bachelor("Ivanov", "Ivan", "PZ-24-1/9", 1, 55.0),
                        new Bachelor("Petrov", "Petro", "KMP-22-2/9", 2, 70.0),
                        new Master("Sidorov", "Sidor", "MD-23-1/9", 1, 80.0, true, true),
                        new Master("Kuznetsov", "Kuzma", "KMP-23-1/9", 2, 65.0, false, true),
                        new PhD("Vasilyev", "Vasyl", "MD-25-2/9", 1, 92.0, true, true),
                        new PhD("Pavlov", "Pavel", "PZ-23-1/9", 2, 50.0, false, false)
                };

                System.out.println("Scholarship Results:");
                System.out.println("--------------------------------------------------------");
                for (Student s : students) {
                        System.out.println(s.toString());
                }
        }
}

class Student {
        protected String lastName_;
        protected String firstName_;
        protected String group_;
        protected int studyYear_;
        protected double minScholarship_;
        protected double ratingScore_;

        public Student(String lastName, String firstName, String group, int studyYear, double minScholarship, double ratingScore)
        {
                this.lastName_ = lastName;
                this.firstName_ = firstName;
                this.group_ = group;
                this.studyYear_ = studyYear;
                this.minScholarship_ = minScholarship;
                this.ratingScore_ = ratingScore;
        }

        public double getScholarship()
        {
                return this.minScholarship_ * this.getScholarshipFactor();
        }

        @Override
        public String toString()
        {
                return String.format("%s %s, Group: %s, Year: %d, Score: %.2f, Schoolarship: %.2f",
                        this.firstName_, this.lastName_,
                        this.group_, this.studyYear_, this.ratingScore_, this.getScholarship());
        }

        protected double getRatingScore()
        {
                return ratingScore_;
        }
        protected double getScholarshipFactor()
        {
                double score = this.getRatingScore();

                if (score <= 60) {
                        return 1;
                } else if (score < 75) {
                        return 1.2;
                } else if (score < 90) {
                        return 1.35;
                } else {
                        return 1.5;
                }
        }
}

class Bachelor extends Student {
        private static final double DEFAULT_MIN_SCHOLARSHIP = 1000;
        public Bachelor(String lastName, String firstName, String group, int studyYear, double ratingScore)
        {
                super(lastName, firstName, group, studyYear, DEFAULT_MIN_SCHOLARSHIP, ratingScore);
        }
}

class NotBachelor extends Student {
        private boolean hasResearchPapers_;
        private boolean isBudgetPlace_;

        public NotBachelor(String lastName, String firstName, String group, int studyYear,
                           double minScholarship, double ratingScore,
                           boolean hasResearchPapers, boolean isBudgetPlace)
        {
                super(lastName, firstName, group, studyYear, minScholarship, ratingScore);
                this.hasResearchPapers_ = hasResearchPapers;
                this.isBudgetPlace_ = isBudgetPlace;
        }

        @Override
        public String toString()
        {
                return super.toString() +
                       (this.isBudgetPlace_ ? ", Budget" : ", Contract") +
                       (this.hasResearchPapers_ ? ", Has research papers" : "");
        }

        @Override
        protected double getRatingScore()
        {
                return super.ratingScore_ * (this.hasResearchPapers_ ? 1.1 : 1.0);
        }

        @Override
        protected double getScholarshipFactor()
        {
                return this.isBudgetPlace_ ? super.getScholarshipFactor() : 0.0;
        }
}

class Master extends NotBachelor {
        private static final double DEFAULT_MIN_SCHOLARSHIP = 1500;

        public Master(String lastName, String firstName, String group, int studyYear,
                      double ratingScore, boolean hasResearchPapers, boolean isBudgetPlace)
        {
                super(lastName, firstName, group, studyYear, DEFAULT_MIN_SCHOLARSHIP,
                        ratingScore, hasResearchPapers, isBudgetPlace);
        }
}

class PhD extends NotBachelor {
        private static final double DEFAULT_MIN_SCHOLARSHIP = 2000;

        public PhD(String lastName, String firstName, String group, int studyYear,
                      double ratingScore, boolean hasResearchPapers, boolean isBudgetPlace)
        {
                super(lastName, firstName, group, studyYear, DEFAULT_MIN_SCHOLARSHIP,
                        ratingScore, hasResearchPapers, isBudgetPlace);
        }
}
