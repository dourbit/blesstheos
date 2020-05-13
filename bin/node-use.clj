#!/usr/bin/env bb

(def check (first *command-line-args*))
(def these ["lts/*" "stable" "default" "current"])

(defn in?
  "true if el is contained in a given coll"
  [el coll]
  (boolean (some #{el} coll)))

(if (nil? check)
  (do
    (println (str these))
    (System/exit 1))
  (in? check these))
