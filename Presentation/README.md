# Presentation

## Analysis

#### I chose to analyze "dispense" from the album ["not-their-technology"](https://github.com/illiichi/not-their-technologies/blob/develop/src/not_their_technologies/core.clj) by illiichi. I saw that this artist is from Japan. Since I'm also Japanese, I thought it would be interesting to analyze piece by someone who's from Japan.

# Code 

> #### This code is written in Clojure which is a programming language. It's not written in sclang.

	(ns not-their-technologies.core
  	(:use [overtone.core]))
  	
  	(connect-external-server "localhost" 57110)
  	

	(defmacro rotate-> [snd pos]
	  `(let [[snd1# snd2#] ~snd] (rotate2 snd1# snd2# 	~pos)))
	(defn n-range [min max num]
	  	(range min max (/ (- max min) num)))
	  	
	  	
	  	(play 50
      (-> (map #(* (sin-osc %1)
                   (lf-pulse (lin-exp (lf-saw:kr 1/48 %2) -1 1 1/4 2)
                             0 1/16))
               (reductions * 500 (cycle [5/4 4/3 6/5]))
               (range 3/2 2 1/24))
          splay
          (hold 48 0 0)
          (* 32 (env-gen (envelope [1 1 0] [(* 3 48) 0] 0)))
          free-verb
          (rotate-> (sin-osc 1))
          tanh))
          
### Why does this code use Clojure instead of C++?

##### This code uses a sound synthesis library called [Overtone](https://github.com/overtone/overtone/blob/master/README.md) which built on Clojure. Overtone talks to Supercollider (scsynth).

### What do you need to use Overtone?

##### To install Overtone, you need to install Clojure ,which needs Java Script to be installed.

##### 1, Install [JDK](https://www.oracle.com/java/technologies/downloads/?er=221886#jdk24-mac)(Java Development Kit)

##### 2, Go to Terminal and install Clojure and Overtone. [Tutorial](https://www.youtube.com/watch?v=eUixwf64sHg)

# Code Breakdown

## - ns

##### ns stands for namespace. It contains variables or classes. It can let you load libraries by using `:use` `:require` or `:import`. 

## - (:use [overtone.core])

##### `:use` to load libraries and overtone.core is to bring in all functions of Overtone.

## - (connect-external-server "localhost" 57110)

##### Since it uses Overtone as a synth, this code tells Overtone to connect to Supercollider server.

## - [macro](https://clojure.org/reference/macros)

##### [Macro](https://clojure.org/reference/macros) is a system in Clojure which allows you to write code that writes code, making it easier to create repetitive patterns

## - -> (Threading Macros)

##### Convert nested functions into a linear flow functions

## - (defmacro rotate-> [snd pos]
##### Defining rotate as a macro and takes argument `snd` and `pos`

## - [let](https://clojuredocs.org/clojure.core/let)

##### let binds 2 variable

	(let [[snd1# snd2#] (sin-osc 1)] (rotate2 snd1# snd2# pos))
	 
##### It take snd and break it into snd1 and snd2 and calls rotate 2

## - [defn](https://clojure.org/guides/learn/functions)

##### define a named function

## - (defn n-range [min max num]

##### n-range takes three argument

## - (range min max (/ (- max min) num)))

##### Range is from `min` to `max`. The step size `min` to `max` will be divided by `num`.

## (play 50

##### Time duration

## [map](https://clojuredocs.org/clojure.core/map)

##### `map` is used with multiple collections (arguments). 
	ex) (map + [1 2 3] [4 5 6])=>(5 7 9)
	
## (sin-osc %1)

##### generate a sine wave oscillator from Overtone. (First argument of `map`)

## (lf-pulse (lin-exp (lf-saw:kr 1/48 %2) -1 1 1/4 2) 0 1/16))

#### generate a low frequency pulse wave. It is modulated by (lin-exp (lf-saw:kr 1/48 %2) -1 1 1/4 2) 0 1/16))

## (hold 48 0 0)

#### hold the note for duration of 48ms.

## free-verb

#### Reverb effect in Overtone

## tanh

#### Distortion effect in Overtone

## splay

#### spread sound in diverging sides


## Codes I wasn't sure about

* (range 3/2 2 1/24))
* (rotate-> (sin-osc 1))
* (reductions * 500 (cycle [5/4 4/3 6/5]))


## Summary

#### This piece uses Clojure as a programming language, Overtone as a sound library, and Supercollider as an engine.


## Challenging part

##### I had to use terminal to download Clojure and Ovrtone. Even with documentation, it wasn't easy at all. I needed to read and watch multiple sources to install them. 

##### Since I wanted to play on my supercollider, I installed everything I needed. But I still got some error message and couldn't figure out before this presentation.

##### While I was installing in terminal, I found out that I couldn't find scsynth anywhere in my file. Some people said you can't find it if you use macbook, but I couldn't find the certain answer.

##### Since I wasn't able to use Overtone, it was hard to figure out what code does what function. Took me long time to figure out using documentation. There weren't many information about Overtone.

## Sources
##### [Clojure Website](https://clojure.org/reference/namespaces)
##### [Clojure Installation + Overtone Tutorial](https://www.youtube.com/watch?v=eUixwf64sHg)
##### [Clojure - macros](https://clojure.org/reference/macros)
##### [Clojure - defn](https://clojure.org/guides/learn/functions)
##### [Clojure - map](https://clojuredocs.org/clojure.core/map)
##### [Overtone Repository](https://github.com/overtone/overtone)
##### [Overtone Installation](https://github.com/overtone/overtone/blob/master/README.md)
##### [JDK Installation](https://www.oracle.com/java/technologies/downloads/?er=221886#jdk24-mac)
##### [JDK Installation Youtube Tutorial](https://www.youtube.com/watch?v=PQk9O03cukQ)
 
