#ifndef __MAYOR_PRICE_LEVEL_MQH__
#define __MAYOR_PRICE_LEVEL_MQH__

static const int MAYOR_LEVEL_POINTS{3};

static const int candle_travel_distance{200};

bool MAYOR_PRICE_LEVEL_BULLISH{false};

bool MAYOR_PRICE_LEVEL_BEARISH{false};

/**
 * @brief Returns true if finding MAYOR_LEVEL_POINTS
 * 
 * @return true 
 * @return false 
 */
bool mayor_price_level_found()
{
    bool status{false}; // final return statement
    int points{0};

    bool bullish{false};
    bool bearish{false};

    double current_opening_price = iOpen(NULL, PERIOD_M15, 0);
    double current_closing_price = iClose(NULL, PERIOD_M15 ,0); // Timeframe on current chart (second 0)

    // the bullish road
    if (mayor_price_level_bullish(current_closing_price))
    {
        printf("Found a potential bullish mayor price leve\n");
        points += mayor_price_level_close_near(current_closing_price);
        points += mayor_price_level_highs(current_closing_price);
    }
    
    // the bearish road
    if (mayor_price_level_bearish(current_closing_price))
    {
        printf("Found a potential bearish mayor price leve\n");
        points += mayor_price_level_close_near(current_closing_price);
        points += mayor_price_level_lows(current_closing_price);
    }




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
int mayor_price_level_lows(double price)
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
    bool status{true};

    for (int i = 0; i < candle_travel_distance; i++)
    {
        if ((price - iClose(NULL, PERIOD_M15, i)) > 0.01) // 
        {
            status = false;
        }
    }

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