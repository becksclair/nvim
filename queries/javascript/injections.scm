((string) @sql
  (#match? @sql ".*--sql.*"))

((template_string) @sql
  (#match? @sql ".*--sql.*"))

((string) @sql
  (#match? @sql ".*(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).*"))

((template_string) @sql
  (#match? @sql ".*(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).*"))

