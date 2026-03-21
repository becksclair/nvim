;; extends

;; Inline XML/HTML tags with snake_case support
;; Matches <my_tag>, <my-tag>, <MyTag>, </my_tag>, <my_tag/>, etc.
(
  (inline) @injection.content
  (#match? @injection.content "</?[a-zA-Z_][a-zA-Z0-9_:-]*[^>]*/?>")
  (#set! injection.language "xml")
  (#set! injection.include-children)
)

;; Multi-word inline tags that span content like <my_tag>content</my_tag>
(
  (inline) @injection.content
  (#match? @injection.content "<[a-zA-Z_][a-zA-Z0-9_:-]*>[^<]*</[a-zA-Z_][a-zA-Z0-9_:-]*>")
  (#set! injection.language "xml")
  (#set! injection.include-children)
)
