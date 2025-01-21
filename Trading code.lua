// This Pine Script™ code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © TijaRo0

//@version=5
strategy("GOOGLE 20%", overlay = true, shorttitle = "GOO20%", initial_capital = 10000, default_qty_value = 100, default_qty_type = strategy.percent_of_equity, commission_value = 0.025)

fastEMA = ta.ema(close,24)
fastSMA = ta.sma(close,24)
slowEMA = ta.ema(close,200)
atr = ta.atr(14)

goLongCondition1 = fastEMA > fastSMA
goLongCondition2 = fastEMA > slowEMA 
exitLongCondition1 = fastEMA < fastSMA
exitLongCondition2 = close < slowEMA

exitShortCondition1 =goLongCondition1
exitShortCondition2 = goLongCondition2

inTrade = strategy.position_size > 0
notInTrade = strategy.position_size <= 0

timePeriod = time >= timestamp(syminfo.timezone, 2020, 12, 15, 0, 0)

if(timePeriod and goLongCondition1 and goLongCondition2 and notInTrade)
    strategy.entry("long", strategy.long)
    stopLoss = close - atr * 2
    strategy.exit("exit", "long", stop=stopLoss)
    
if(exitLongCondition1 and exitLongCondition2 and inTrade)
    strategy.close(id ="long")
    strategy.entry("short", strategy.short)
    stopLoss = close + atr * 2
    strategy.exit("exit","short", stop = stopLoss)

if(exitShortCondition1 and exitShortCondition2 and inTrade)
    strategy.close(id = "short")

plot(fastEMA,color = color.blue)
plot(slowEMA, color = color.yellow)
plot(fastSMA,color = color.purple)
bgcolor(notInTrade ? color.red : color.green)






