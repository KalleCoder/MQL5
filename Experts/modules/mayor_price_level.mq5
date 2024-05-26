#include "mayor_price_level.mqh"

static int candle_travel_distance{200};


bool mayor_price_level_found()
{
    bool status{false};
    int points{0};

    double current_opening_price = iOpen(NULL, 0, 0);
    double current_closing_price = iClose(NULL, 0 ,0); // Timeframe on current chart (second 0)


    if (points == MAYOR_LEVEL_POINTS)
    {
        status = true;
    }

    return status;
}


int mayor_price_level_highs(double price)
{
    int points{0};

    return points;
}


int mayor_price_level_low(double price)
{
    int points{0};

    return points;
}


int mayor_price_level_close_near(double price)
{
    int points{0};

    return points;
}