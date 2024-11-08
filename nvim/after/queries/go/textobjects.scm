; extends

(type_declaration
  (type_spec
    name: (type_identifier) @local.name))

(function_declaration
    name: (identifier) @local.name)

(method_declaration
    name: (field_identifier) @local.name)
