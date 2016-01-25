;;;===================================================================
;;; This file was generated by Org. Do not edit it directly.
;;; Instead, edit Lodox.org in Emacs and call org-babel-tangle.
;;;===================================================================

(defmodule pandoc
  (doc "A partial LFE port of [Pandex][].

[Pandex]: https://github.com/FilterKaapi/pandex")
  (export all))

(include-lib "clj/include/compose.lfe")

(defun convert-string (string)
  "Equivalent to `(`[[convert-string/3]]` string \"markdown_github\" \"html\")`."
  (convert-string string "markdown_github" "html"))

(defun convert-string (string from to)
  "Equivalent to `(`[[convert-string/4]]` string from to [])`."
  (convert-string string from to []))

(defun convert-string (string from to _options)
  (let ((dot-temp ".temp"))
    (if (filelib:is_dir dot-temp) 'ok (file:make_dir dot-temp))
    (let ((name (filename:join dot-temp (random-name))))
      (file:write_file name string)
      (let ((`#(ok ,output) (convert-file name from to)))
        (file:delete name)
        `#(ok ,output)))))

(defun convert-file (file)
  "Equivalent to `(`[[convert-file/3]]` file \"markdown_github\" \"html\")`."
  (convert-file file "markdown" "html"))

(defun convert-file (file from to)
  "Equivalent to `(`[[convert-file/4]]` file from to [])`."
  (convert-file file from to []))

(defun convert-file (file from to _options)
  "[[convert-file/4]] works under the hood of all the other functions."
  (let ((output (os:cmd (++ "pandoc " file " -f " from " -t " to))))
    `#(ok ,output)))

(defun random-name ()
  (++ (random-string) "-" (timestamp) ".md"))

(defun random-string ()
  (random:seed (erlang:monotonic_time)
               (erlang:time_offset)
               (erlang:unique_integer))
  (-> #0x100000000000000
      (random:uniform)
      (integer_to_list 36)
      (string:to_lower)))

(defun timestamp ()
  (let ((`#(,megasec ,sec ,_microsec) (os:timestamp)))
    (-> (* megasec 1000000) (+ sec) (integer_to_list))))
