;; extends

;; XML/HTML code blocks
(fenced_code_block
  (info_string
    (language) @_lang
    (#any-of? @_lang "xml" "html" "xhtml"))
  (code_fence_content) @injection.content
  (#set! injection.language "xml")
  (#set! injection.include-children))

;; LLM prompt style XML blocks with snake_case support
;; Matches <tag_name>...</tag_name>, <TagName>, <tag-name>, etc.
(
  (paragraph) @injection.content
  (#match? @injection.content "<([a-zA-Z_][a-zA-Z0-9_:-]*)[^>]*>.*</[a-zA-Z_][a-zA-Z0-9_:-]*>")
  (#set! injection.language "xml")
  (#set! injection.include-children)
)

;; Self-closing tags with snake_case: <my_tag/>, <my_tag />, <my-tag/>
(
  (paragraph) @injection.content
  (#match? @injection.content "</?[a-zA-Z_][a-zA-Z0-9_:-]*[^>]*/?>")
  (#set! injection.language "xml")
  (#set! injection.include-children)
)
