;;;; nuclear.asd

(asdf:defsystem #:nuclear
  :description "Nuclear music player module for StumpWM"
  :author "Dmitrii Kosenkov"
  :license  "GPLv3"
  :version "0.1.0"
  :serial t
  :depends-on (#:stumpwm #:dexador #:cl-json)
  :components ((:file "package")
               (:file "nuclear")))
