(in-package #:nuclear)

(defparameter *url* "http://localhost:3100")

;; formatters.
(add-screen-mode-line-formatter #\N 'modeline)

(defparameter *modeline-fmt* "%a: %n"
  "The default value for displaying nuclear information on the modeline")

(defparameter *formatters-alist*
  '((#\a  ml-artist)
    (#\n  ml-name)
    (#\d  ml-duration)
    (#\p  ml-progress)
    (#\l  ml-stream-loading)
    (#\s  ml-status)))

(defun dex-post (uri &key params (show-errors t))
  "POST request"
  (handler-case
      (dex:post (concat *url* uri)
                :content params
                :connect-timeout 0.4
                :read-timeout 1
                :keep-alive nil)
    (t (e)
      (when show-errors
        (message (format nil "Nuclear API error: ~a~%" e))))))

(defun dex-get (uri &key show-errors)
  "GET request"
  (handler-case
      (dex:get (concat *url* uri)
                :connect-timeout 0.4
                :read-timeout 1
                :keep-alive nil)
    (t (e)
      (when show-errors
        (message (format nil "Nuclear API error: ~a~%" e))))))


(defun now-playing ()
  (multiple-value-bind (body status)
      (dex-get "/nuclear/player/now-playing" :show-errors nil)
    (when (eq status 200)
      (json:decode-json-from-string body))))

(defun modeline (ml)
  (declare (ignore ml))
  (ignore-errors
   (when-let ((data (now-playing)))
     (format-expand *formatters-alist*
                    *modeline-fmt*
                    data))))

(defun ml-artist (data)
  (cdr (assoc :ARTIST data)))

(defun ml-name (data)
  (cdr (assoc :NAME data)))

(defun ml-duration (data)
  (cdr (assoc :DURATION data)))

(defun ml-progress (data)
  (cdr (assoc :PLAYBACK-PROGRESS data)))

(defun ml-status (data)
  (cdr (assoc :PLAYBACK-STATUS data)))

(defun ml-stream-loading (data)
  (cdr (assoc :PLAYBACK-STREAM-LOADING data)))

(defcommand nuclear-next () ()
  (dex-post "/nuclear/player/next"))

(defcommand nuclear-previous () ()
  (dex-post "/nuclear/player/previous"))

(defcommand nuclear-pause () ()
  (dex-post "/nuclear/player/pause"))

(defcommand nuclear-play-pause () ()
  (dex-post "/nuclear/player/play-pause"))

(defcommand nuclear-stop () ()
  (dex-post "/nuclear/player/stop"))

(defcommand nuclear-play () ()
  (dex-post "/nuclear/player/play"))

(defcommand nuclear-mute () ()
  (dex-post "/nuclear/player/mute"))

(defcommand nuclear-quit () ()
  (dex-post "/nuclear/player/quit"))

(defcommand nuclear-show-playing () ()
  (when-let* ((data (now-playing))
              (artist (ml-artist data))
              (name (ml-name data)))
    (message (format nil "Nuclear playing: \"~A\" by \"~A\"" name artist))))
