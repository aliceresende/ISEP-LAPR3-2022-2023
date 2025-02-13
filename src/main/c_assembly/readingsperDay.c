long readingsperDay(float freq) {
        float readingperDay = (float) (3600/freq)*24;
        return (long)(readingperDay);
}