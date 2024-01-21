; Conceal bullet points.
([
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)
 ] @punctuation.special
  (#offset! @punctuation.special 0 0 0 -1)
  (#set! conceal "󰧞"))

([
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)
 ] @punctuation.special
  (#any-of? @punctuation.special "+" "*" "-")
  (#set! conceal "󰧞"))

; Conceal unchecked task list items.
((task_list_marker_unchecked) @text.todo.unchecked
  (#offset! @text.todo.unchecked 0 -2 0 0)
  (#set! conceal "󰄱"))

; Conceal checked task list items.
((task_list_marker_checked) @text.todo.checked
  (#offset! @text.todo.checked 0 -2 0 0)
  (#set! conceal "󰄲"))

; Set a highlight for the text of checked task list items.
(list_item
 (task_list_marker_checked)
 (_) @text.todo.checked.text)

; Set a highlight for the text of unchecked task list items.
(list_item
 (task_list_marker_unchecked)
 (_) @text.todo.unchecked.text)

; Headers
((atx_h1_marker) @heading.marker
  (#set! conceal "1"))

((atx_h2_marker) @heading.marker
  (#set! conceal "2"))

((atx_h3_marker) @heading.marker
  (#set! conceal "3"))

((atx_h4_marker) @heading.marker
  (#set! conceal "4"))

((atx_h5_marker) @heading.marker
  (#set! conceal "5"))

((atx_h6_marker) @heading.marker
  (#set! conceal "6"))

(inline) @spell
