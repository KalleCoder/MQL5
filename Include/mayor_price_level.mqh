#ifndef __MAYOR_PRICE_LEVEL_MQH__
#define __MAYOR_PRICE_LEVEL_MQH__

int const MAYOR_LEVEL_POINTS{3};

static const int candle_travel_distance{200};

/**
 * @brief Returns true if finding MAYOR_LEVEL_POINTS
 * 
 * @return true 
 * @return false 
 */
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


/**
 * @brief returning the amount of highs that are close enough to award a point towards a mayor price level
 * 
 * @return int 
 */
int mayor_price_level_highs(double price)
{
    int points{0};

    return points;
}

/**
 * @brief returns the amount of low that are close enough to award a point towards a mayor price level
 * 
 * @return int 
 */
int mayor_price_level_low(double price)
{
    int points{0};

    return points;
}


/**
 * @brief retrun the amount of candle closes that close enough to award a point towards a mayor price level 
 * 
 * @return int 
 */
int mayor_price_level_close_near(double price)
{
    int points{0};

    return points;
}

/**
 * @brief to find out if the mayor level is bearish
 * 
 */
bool mayor_price_level_bearish(double price)
{
    bool status{false};

    return status;
}

/**
 * @brief to find out if the mayor level is bullish
 * 
 * @return true 
 * @return false 
 */
bool mayor_price_level_bullish(double price)
{
    bool status{false};

    return status;
}


#endif 