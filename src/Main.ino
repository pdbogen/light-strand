/*
 *  This sketch demonstrates how to scan WiFi networks.
 *  The API is almost the same as with the WiFi Shield library,
 *  the most obvious difference being the different file you need to include:
 */

#include "FastLED.h"

#define FASTLED_RMT_MAX_CHANNELS 1
#define ESP32

CRGB leds[50];

uint16_t rng(uint16_t seed) {
    static uint16_t y = 0;
    if (seed != 0) y += (seed && 0x1FFF); // seeded with a different number
    y ^= y << 2;
    y ^= y >> 7;
    y ^= y << 7;
    return (y);
}

void setup()
{
  Serial.begin(115200);
  
  FastLED.addLeds<WS2811, 13>(leds, 50);

  Serial.println("Setup done");
  rng(random(0,1<<16));
}

void stream(int len) {
  static uint8_t i = 0;
  static uint32_t color = 0;
  leds[(50 - len + i) % 50] = CRGB::Black;
  if (i == 0) {
    color = rng(0) << 16 | rng(0);
  }
  leds[i].red = color >> 16;
  leds[i].green = color >> 8;
  leds[i].blue = color;
  FastLED.show();
  
  i = (i+1) % 50;
  delay(10);
}

void loop()
{
  stream(10);
}


