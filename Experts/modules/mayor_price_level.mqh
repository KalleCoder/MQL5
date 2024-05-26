#ifndef MAYOR_PRICE_LEVEL_MQH
#define MAYOR_PRICE_LEVEL_MQH

int MAYOR_LEVEL_POINTS{3};

/**
 * @brief Returns true if finding MAYOR_LEVEL_POINTS
 * 
 * @return true 
 * @return false 
 */
bool mayor_price_level_found();


/**
 * @brief returning the amount of highs that are close enough to award a point towards a mayor price level
 * 
 * @return int 
 */
int mayor_price_level_highs();

/**
 * @brief returns the amount of low that are close enough to award a point towards a mayor price level
 * 
 * @return int 
 */
int mayor_price_level_low();


/**
 * @brief retrun the amount of candle closes that close enough to award a point towards a mayor price level 
 * 
 * @return int 
 */
int mayor_price_level_close_near();


#endif 