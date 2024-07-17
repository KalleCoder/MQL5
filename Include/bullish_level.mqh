#ifndef __BULLISH_LEVEL_MQH__
#define __BULLISH_LEVEL_MQH__

static const int MAYOR_LEVEL_POINTS{3};

static const int candle_travel_distance{200};

static bool MAYOR_PRICE_LEVEL_BULLISH{false};

/**
 * @brief Returns true if finding MAYOR_LEVEL_POINTS
 *
 * @return true
 * @return false
 */
bool bullish_price_level_found()
{
    bool status{false}; // final return statement
    int points{0};

    double current_opening_price = iOpen(NULL, PERIOD_M15, 0);
    double current_closing_price = iClose(NULL, PERIOD_M15, 0); // Timeframe on current chart (second 0)

    // the bullish road
    if (mayor_price_level_bullish(current_closing_price))
    {
        // printf("Found a potential bullish mayor price level\n");
        points += bullish_level_mayor_price_level_close_near(current_closing_price);
        points += bullish_level_mayor_price_level_highs(current_closing_price);
    }

    if (points == MAYOR_LEVEL_POINTS)
    {
        PrintFormat("Found a bullish mayor price level at: %.5f", current_closing_price);
        status = true;
    }

    return status;
}

/**
 * @brief returning the amount of highs that are close enough to award a point towards a mayor price level
 *
 * @return int
 */
int bullish_level_mayor_price_level_highs(double price)
{
    int points{0};

    for (int i = 0; i < candle_travel_distance; i++)
    {
        double high_price = iHigh(NULL, PERIOD_M15, i);
        if ((high_price - price) > 0.01) // a larger view of it
        {
            points++;

            datetime candle_time = iTime(NULL, PERIOD_M15, i); // Get the time of the candle
            PrintFormat("Gained a high point at price: %.5f, Date and Time: %s", high_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
        }
    }

    return points;
}

/**
 * @brief retrun the amount of candle closes that close enough to award a point towards a mayor price level
 *
 * @return int
 */
int bullish_level_mayor_price_level_close_near(double price)
{
    int points{0};

    for (int i = 0; i < candle_travel_distance; i++)
    {
        double close_price = iClose(NULL, PERIOD_M15, i);
        if ((close_price - price) > 0.01) // a larger view of it
        {
            points++;

            datetime candle_time = iTime(NULL, PERIOD_M15, i); // Get the time of the candle
            PrintFormat("Gained a close point at price: %.5f, Date and Time: %s", close_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
        }
    }

    return points;
}

/**
 * @brief to find out if the mayor level is bullish
 *
 * @return true
 * @return false
 */
bool mayor_price_level_bullish(double price)
{
    bool status{true};

    for (int i = 0; i < candle_travel_distance; i++) // starting 50 candles behind from current.
    {
        if ((iClose(NULL, PERIOD_M15, i) - price) > 0.01) // a larger view of it
        {
            status = false;
        }
    }

    return status;
}

#endif