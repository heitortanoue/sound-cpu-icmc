#include "../headers/waves.h"
#include <SDL2/SDL.h>
#include <SDL2/SDL_audio.h>
#include <queue>
#include <cmath>

double sineWave(double freq, double amplitude, double v){
    return amplitude * std::sin(v * 2 * M_PI / freq);
}

double squareWave(double freq, double amplitude, double v){
    double w = v * 2 * M_PI / freq;
    double value = std::sin(w) >= 0.0 ? 1.0 : -1.0;

    return (value * amplitude);
}

double triangleWave(double freq, double amplitude, double v){
    double w = v * 2 * M_PI / freq;
    double value = (2.0 / M_PI) * std::asin(std::sin(w));

    return (value * amplitude);
}

double sawtoothWave(double freq, double amplitude, double v){
    double wave = 2 * ( (v/freq) - std::floor(0.5 + (v/freq)) );

    return (wave * amplitude);
}

