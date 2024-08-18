#ifndef _HIGH_PRICE_MQH__
#define __HIGH_PRICE_MQH__

int MAYOR_HIGH_LEVEL_POINTS{0};

int TRAVEL_DISTANCE{200};

bool MAYOR_PRICE_LEVEL_BULLISH{false};

int bullish_close_points{0}; // variable to track the candles that closed och reached very close to the HIGH_PRICE_CLOSE
int bullish_peak_points{0};  // variable to track the candles that closed och reached very close to the HIGH_PRICE_PEAK

double HIGH_PRICE_CLOSE{0}; // variable to track the price
double HIGH_PRICE_PEAK{0};  // variable to track the price

int candles_since_last_HIGH_PRICE_CLOSE{0}; // to know when reset to the new HIGH_PRICE_CLOSE

void startup_finding_high_prices()
{
    int close_tracker{0}; // to add to candles_since_last_HIGH_PRICE_CLOSE

    for (int i = TRAVEL_DISTANCE; i > 1; i--)
    {
        double closing_price = iClose(NULL, PERIOD_M15, i); // Timeframe on current chart (second 0)
        double high_price = iHigh(NULL, PERIOD_M15, i);

        if (closing_price > HIGH_PRICE_CLOSE)
        {

            bool peak{true};

            // TO see if its a peak first
            for (int t = i; t > i + 3; t++)
            {
                double closing_price_inner = iClose(NULL, PERIOD_M15, t);
                if (closing_price < closing_price_inner)
                {
                    peak = false;
                }
            }

            if (peak)
            {
                HIGH_PRICE_CLOSE = closing_price;
                HIGH_PRICE_PEAK = high_price;
                close_tracker = i;
            }
        }

        if (high_price > HIGH_PRICE_PEAK && i - close_tracker < 3)
        {
            HIGH_PRICE_PEAK = high_price;
        }
    }

    candles_since_last_HIGH_PRICE_CLOSE = close_tracker;

    datetime candle_time = iTime(NULL, PERIOD_M15, 0); // Get the time of the candle
    PrintFormat("THE CURRENT HIGH_CLOSE_PRICE: %.5f, Date and Time: %s", HIGH_PRICE_CLOSE, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
    PrintFormat("THE CURRENT HIGH_PRICE_PEAKE: %.5f, Date and Time: %s", HIGH_PRICE_PEAK, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
}

void new_high_price()
{
    double current_closing_price = iClose(NULL, PERIOD_M15, 0); // Timeframe on current chart (second 0)
    double current_high_price = iHigh(NULL, PERIOD_M15, 0);

    if (candles_since_last_HIGH_PRICE_CLOSE == TRAVEL_DISTANCE)
    {
        MAYOR_HIGH_LEVEL_POINTS = 0;
        startup_finding_high_prices(); /// HAS GONE WAY TO LONG SO ITS TIME TO CHECK FOR NEW HIGH
    }

    if (current_closing_price > HIGH_PRICE_CLOSE)
    {
        HIGH_PRICE_CLOSE = current_closing_price;
        datetime candle_time = iTime(NULL, PERIOD_M15, 0); // Get the time of the candle
        PrintFormat("NEW HIGH CLOSE PRICE: %.5f, Date and Time: %s", current_closing_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
        candles_since_last_HIGH_PRICE_CLOSE = 0;
    }

    if (current_high_price > HIGH_PRICE_PEAK && candles_since_last_HIGH_PRICE_CLOSE < 3)
    {
        HIGH_PRICE_PEAK = current_high_price;
        datetime candle_time = iTime(NULL, PERIOD_M15, 0); // Get the time of the candle
        PrintFormat("NEW HIGH PEAK PRICE: %.5f, Date and Time: %s", current_high_price, TimeToString(candle_time, TIME_DATE | TIME_MINUTES));
    }

    candles_since_last_HIGH_PRICE_CLOSE += 1;
}

#endif