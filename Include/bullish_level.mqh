#ifndef __BULLISH_LEVEL_MQH__
#define __BULLISH_LEVEL_MQH__

static const int MAYOR_LEVEL_POINTS{3};

static const int candle_travel_distance{150};

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
    double previous_closing_price = iClose(NULL, PERIOD_M15, 1);
    double current_closing_price = iClose(NULL, PERIOD_M15, 0); // Timeframe on current chart (second 0)
    double current_high_price = iHigh(NULL, PERIOD_M15, 0);

    // the bullish road
    if (bullish_mayor_price_level(current_closing_price))
    {
        if (bullish_previous_candle_filter(current_closing_price))
        {
            printf("Found a potential bullish mayor price level\n");
            points = bullish_level_mayor_price_level_peaks();
        }
    }

    if (points == MAYOR_LEVEL_POINTS)
    {
        PrintFormat("Found a bullish mayor price level at: %.5f", current_closing_price);
        status = true;
    }

    return status;
}

/**
 * @brief to find out if the mayor level is bullish
 *
 * @return true
 * @return false
 */
bool bullish_mayor_price_level(double price)
{
    bool status{true};

    for (int i = 0; i < candle_travel_distance; i++) // the distance to look back
    {

        if ((iClose(NULL, PERIOD_M15, i) - price) > 0.0005) // a larger view of it
        {
            status = false;
            break;
        }
    }

    return status;
}

/**
 * @brief When a new high is found this function prevents points from being gained from the nearest candles
 *
 * @param price
 * @return true
 * @return false
 */
bool bullish_previous_candle_filter(double price)
{
    bool status{true};

    for (int i = 1; i < 10; i++)
    {
        if (iClose(NULL, PERIOD_M15, i) > price)
        {
            // printf("Candles before was higher!\n");
            status = false;
            break;
        }
    }

    return status;
}

/**
 * @brief retrun the amount of candle closes that close enough to award a point towards a mayor price level
 *
 * @return int
 */
int bullish_level_mayor_price_level_peaks()
{
    int points{0};

    double current_closing_price = iClose(NULL, PERIOD_M15, 0); // Timeframe on current chart (second 0)
    double current_high_price = iHigh(NULL, PERIOD_M15, 0);

    bool found_close{false};

    for (int i = 10; i < candle_travel_distance; i++)
    {
        double close_price = iClose(NULL, PERIOD_M15, i);
        if (MathAbs(close_price - current_closing_price) < 0.00015) // NEED TO ADD A LESSER STRICT FILTER FOR OLDER CANDLES
        {
            // when FINDING A POINT YOU MAKE A FILTER AND PICK THE HIGHEST PRICE OF THE 3/4 closest candles
            points++;

            datetime candle_time = iTime(NULL, PERIOD_M15, i); // Get the time of the candle
            PrintFormat("Gained a close point at price: %.5f, Date and Time: %s", close_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
            i += 15; // to not take the candle right after
            found_close = true;
        }

        double high_price = iHigh(NULL, PERIOD_M15, i);
        if (MathAbs(high_price - current_high_price) < 0.00015) // NEED TO ADD A LESSER STRICT FILTER FOR OLDER CANDLES
        {
            points++;

            datetime candle_time = iTime(NULL, PERIOD_M15, i); // Get the time of the candle
            PrintFormat("Gained a high point at price: %.5f, Date and Time: %s", high_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
            i += 15;
        }

        found_close = false;
    }

    return points;
}

#endif