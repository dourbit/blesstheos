{:user {:dependencies [[clj-kondo "RELEASE"]]
        :aliases {"clj-kondo" ["run" "-m" "clj-kondo.main"]}
        :plugins [[com.gfredericks/lein-how-to-ns "0.2.7"]
                  [jonase/eastwood "0.3.11"]
                  [lein-ancient "0.6.15"]
                  [lein-bikeshed "0.5.2"]
                  [lein-cljfmt "0.6.7"]
                  [lein-kibit "0.1.8"]
                  [lein-difftest "2.0.0"]
                  [lein-marginalia "0.9.1"]
                  [lein-pprint "1.3.2"]]}
 :repl {:dependencies [[alembic "0.3.2"]]}}
