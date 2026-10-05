public class Task1 {
        public static void main(String[] args)
        {
                Flower flower = new Flower();
                Bush bush = new Bush();
                Tree tree = new Tree();

                Plant[] plants = {flower, bush, tree};

                for (int i = 0; i < 10; ++i) {
                        System.out.println("\n" + i * 100 + " days:");
                        for (Plant p : plants) {
                                p.printInfo();
                                p.grow(100);
                        }
                }
        }
}

class Plant {
        protected int age_; // in days
        protected double height_; // in meters
        protected boolean dead_ = false;

        Plant() { this(0, 0); }
        Plant(int age, double height)
        {
                this.age_ = age;
                this.height_ = height;
        }

        void grow(int daysPassed) { this.age_ += daysPassed; }
        void printInfo()
        {
                System.out.println("Age: " + this.age_ +
                                   " days, Height: " + this.height_ +
                                   " meters, " + (this.dead_ ? "Dead" : "Alive"));
        }

        // Getters
        int age()      { return this.age_; }
        double height() { return this.height_; }
        boolean dead() { return this.dead_; }

        // Setters
        void age(int age)          { this.age_ = Math.max(age, 0); }
        void height(double height) { this.height_ = Math.max(height, 0); }
        void dead(boolean dead)    { this.dead_ = dead; }
}

class Flower extends Plant {
        private static final double HEIGHT_MIN = 0.01;
        private static final double HEIGHT_LIMIT = 0.3;
        private static final int AGE_LIMIT = 200; // One-seasoned flower
        private static final int GROWTH_AGE_LIMIT = 120;

        protected String color_;

        Flower() { this(0, HEIGHT_MIN, "Red"); }

        Flower(int age, double height, String color)
        {
                super(age, height);
                this.color_ = color;
        }

        @Override
        void grow(int daysPassed)
        {
                super.grow(daysPassed);

                super.height_ = HEIGHT_MIN + (HEIGHT_LIMIT - HEIGHT_MIN) *
                                             ((double)Math.min(super.age_, GROWTH_AGE_LIMIT) / GROWTH_AGE_LIMIT);

                super.dead_ = (super.age_ > AGE_LIMIT);
                if (super.dead_) this.color_ = "Rotten gray";
        }

        @Override
        void printInfo()
        {
                System.out.print("Flower of " + this.color_ + " color, ");
                super.printInfo();
        }

        String color() { return this.color_; }
        void color(String color) { this.color_ = color; }

        @Override
        void height(double height)
        {
                this.height_ = Math.clamp(height, HEIGHT_MIN, HEIGHT_LIMIT);
        }
}

class Bush extends Plant {
        private static final double HEIGHT_MIN = 0.01;
        private static final double HEIGHT_LIMIT = 1.5;
        private static final int AGE_LIMIT = 365 * 5;
        private static final int GROWTH_AGE_LIMIT = 365;

        protected boolean hasSpikes_;

        Bush() { this(0, HEIGHT_MIN, false); }

        Bush(int age, double height, boolean hasSpikes)
        {
                super(age, height);
                this.hasSpikes_ = hasSpikes;
        }

        @Override
        void grow(int daysPassed)
        {
                super.grow(daysPassed);

                super.dead_ = (super.age_ > AGE_LIMIT);

                super.height_ = HEIGHT_MIN + (HEIGHT_LIMIT - HEIGHT_MIN) *
                                ((double)Math.min(super.age_, GROWTH_AGE_LIMIT) / GROWTH_AGE_LIMIT);
        }

        @Override
        void printInfo()
        {
                System.out.print("Brush " + (this.hasSpikes_ ? "with" : "without") + " spikes, ");
                super.printInfo();
        }

        boolean hasSpikes() { return this.hasSpikes_; }
        void hasSpikes(boolean hasSpikes) { this.hasSpikes_ = hasSpikes; }

        @Override
        void height(double height)
        {
                this.height_ = Math.clamp(height, HEIGHT_MIN, HEIGHT_LIMIT);
        }
}

class Tree extends Plant {
        private static final double HEIGHT_MIN = 0.5;
        private static final double HEIGHT_MAX = 50;
        private static final int CIRCLE_AGE = 10;
        private static final int GROWTH_AGE_LIMIT = 365 * 3;

        protected int circles_ = 0;

        Tree() { this(0, HEIGHT_MIN); }

        Tree(int age, double height)
        {
                super(age, height);
                this.circles_ = super.age_ / CIRCLE_AGE;
        }

        @Override
        void grow(int daysPassed)
        {
                super.grow(daysPassed);
                this.updateCircles();

                double t = Math.min(super.age_, GROWTH_AGE_LIMIT);

                // integral of Math.sin(Math.PI * (t / GROWTH_AGE_LIMIT));
                super.height_ = HEIGHT_MIN + (HEIGHT_MAX - HEIGHT_MIN)
                                             * (1 - Math.cos(Math.PI * (t / GROWTH_AGE_LIMIT)));
        }

        @Override
        void printInfo()
        {
                System.out.print("Tree, Circles: " + this.circles_ + ", ");
                super.printInfo();
        }

        int circles() { return this.circles_; }
        void updateCircles()
        {
                this.circles_ = super.age_ / CIRCLE_AGE;
        }

        @Override
        void height(double height)
        {
                this.height_ = Math.max(height, HEIGHT_MIN);
        }
}
