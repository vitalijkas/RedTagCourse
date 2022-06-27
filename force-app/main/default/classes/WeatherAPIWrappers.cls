public with sharing class WeatherAPIWrappers {

    public class GetWeatherResponse{
        public Decimal timezone;
        public Integer id;
        public String name;
        public Decimal cod;
        public Long dt;
        public String base;
        public Decimal visibility;
        public Coordinates coord;
        public List<Weather> weather;
        public Main main;
        public Wind wind;
        public Clouds clouds;
    }

    public class Coordinates{
        public Decimal lon;
        public Decimal lat;
    }

    public class Weather{
        public Integer id;
        public String main;
        public String description;
        public String icon;
    }

    public class Main{
        public Decimal temp;
        public Decimal feels_like;
        public Decimal temp_min;
        public Decimal temp_max;
        public Decimal pressure;
        public Decimal humidity;
    }

    public class Wind{
        public Decimal speed;
        public Decimal deg;
        public Decimal gust;
    }

    public class Clouds{
        public Decimal all;
    }

    public class Sys{
        public Decimal type;
        public Decimal id;
        public String country;
        public Long sunrise;
        public Long sunset;
    }

}
