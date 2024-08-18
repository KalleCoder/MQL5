#include <bullish_level.mqh>

datetime PREVIOUS_CANDLE_TIME = 0;

static bool BULLISH_MAYOR_LEVEL = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    //---
    PREVIOUS_CANDLE_TIME = 0;

    startup_finding_high_prices();
    //---
    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // MAYBE DOWNLOAD SOME FILES TO SAVE THE DATA
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    datetime current_candle_time = iTime(NULL, PERIOD_M15, 0);

    if (current_candle_time != PREVIOUS_CANDLE_TIME) // triggering after each new candle
    {
        PREVIOUS_CANDLE_TIME = current_candle_time; // making the above if statement work as intended

        new_high_price();
    }
}
//+------------------------------------------------------------------+
