# SYNTAX TEST "Terraform.sublime-syntax"

/////////////////////////////////////////////////////////////////////
// INLINE COMMENTS
/////////////////////////////////////////////////////////////////////

/////
// Start of line inline comments with `#`.
/////

# inline comment
# ^ source.terraform comment.line.terraform

/////
// Start of line inline comments with `//`.
/////

// foo
# ^ source.terraform comment.line.terraform

/////
// Matches at random place in line + punctuation for `#`.
/////

        # bar
#     ^ -comment -punctuation
#       ^ punctuation.definition.comment.terraform
#       ^^^^^ comment.line.terraform

/////
// Matches at random place in line + punctuation for `//`.
/////

    // baz # blah
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^^^^^^^^^^ comment.line.terraform

/////////////////////////////////////////////////////////////////////
// BLOCK COMMENTS
/////////////////////////////////////////////////////////////////////

/////
// Matches for a single line.
/////

    /* foo */
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^^^^^ comment.block.terraform
#          ^^ punctuation.definition.comment.terraform

/////
// Matches over multiple lines.
/////

    /*
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^ comment.block.terraform

  foo
# ^^^^ comment.block.terraform

    */
# ^^^^ comment.block.terraform
#   ^^ punctuation.definition.comment.terraform

/////
// Matches inline comments after block ends.
/////

     /* comment */    // inline
# ^ -comment -punctuation
#    ^^ punctuation.definition.comment.terraform
#    ^^^^^^^^^^^^ comment.block.terraform
#               ^^ punctuation.definition.comment.terraform
#                 ^^^ -comment -punctuation
#                     ^^ punctuation.definition.comment.terraform
#                     ^^^^^^^^ comment.line.terraform

/////////////////////////////////////////////////////////////////////
// LANGUAGE CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches `true`.
/////

    true
# ^ -constant
#   ^^^^ constant.language.terraform
#         ^ -constant

/////
// Matches `false`.
/////

    false
# ^ -constant
#   ^^^^^ constant.language.terraform
#         ^ -constant


/////
// Matches `null`.
/////

    null
# ^ -constant
#   ^^^^ constant.language.terraform
#         ^ -constant


/////////////////////////////////////////////////////////////////////
// INTEGER CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches integers.
/////

    444
# ^ -constant -numeric
#   ^^^ constant.numeric.integer.terraform

/////
// Matches zero.
/////

      0
# ^ -constant -numeric
#     ^ constant.numeric.integer.terraform

/////
// Matches one.
/////

      1
# ^ -constant -numeric
#     ^ constant.numeric.integer.terraform

/////
// Matches large integers.
/////

      26345645634561
# ^ -constant -numeric
#     ^^^^^^^^^^^^^^ constant.numeric.integer.terraform

/////////////////////////////////////////////////////////////////////
// FLOATING-POINT CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches floating-point numbers.
/////

      1.2
# ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform

/////
// Matches large floating-point numbers.
/////

      61.28888888888
#   ^ -constant -numeric
#     ^^ constant.numeric.float.terraform
#       ^ punctuation.separator.decimal.terraform
#        ^^^^^^^^^^^ constant.numeric.float.terraform

/////
// Matches integers with exponents.
/////

      1e12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.exponent.terraform
#       ^^ constant.numeric.float.terraform

/////
// Matches floats with exponents.
/////

      1.4E12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^ punctuation.separator.exponent.terraform
#         ^^ constant.numeric.float.terraform

/////
// Matches floats with postive signed exponents.
/////

      1.4e+12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^^ punctuation.separator.exponent.terraform
#          ^^ constant.numeric.float.terraform

/////
// Matches floats with negative signed exponents.
/////

      1.4E-12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^^ punctuation.separator.exponent.terraform
#          ^^ constant.numeric.float.terraform

/////////////////////////////////////////////////////////////////////
// STRINGS
/////////////////////////////////////////////////////////////////////

/////
// Matches punctuation and assigns meta_scope.
/////

      "a string"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#     ^^^^^^^^^^ string.quoted.double.terraform
#              ^ punctuation.definition.string.end.terraform
#                 ^ -punctuation -string

/////
// Matches character escapes.
/////

      "a \n b \r c \t d \" e \udead f \udeadbeef"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.terraform
#        ^^ constant.character.escape.terraform
#             ^^ constant.character.escape.terraform
#                  ^^ constant.character.escape.terraform
#                       ^^ constant.character.escape.terraform
#                            ^^^^^ constant.character.escape.terraform
#                                     ^^^^^^^^^^ constant.character.escape.terraform
#                                               ^ punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// STRING INTERPOLATION
/////////////////////////////////////////////////////////////////////

/////
// Correct scopes during interpolation.
/////

      "some ${interpolation} string"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#      ^^^^^ string.quoted.double.terraform
#           ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#             ^^^^^^^^^^^^^^ meta.interpolation.terraform
#                          ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                            ^^^^^^^ string.quoted.double.terraform
#                                  ^ punctuation.definition.string.end.terraform
#                                   ^ -punctuation -string

/////
// Matches left-trim and right-trim.
/////

      "%{~ fff ~}"
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#        ^^ meta.interpolation.terraform keyword.operator.template.left.trim.terraform
#          ^^^^^^ meta.interpolation.terraform
#             ^^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#               ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////
// Matches operators
/////

    "${ something ? true : false }"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#    ^^ punctuation.section.interpolation.begin.terraform
#     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                 ^ keyword.operator.terraform
#                   ^^^^ meta.interpolation.terraform constant.language.terraform
#                        ^ meta.interpolation.terraform keyword.operator.terraform
#                          ^^^^^ meta.interpolation.terraform constant.language.terraform
#                                ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                 ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////
// Dot-access attributes in string interpolation
/////

    "hello ${aws_instance.ubuntu}"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#   ^^^^^^^ string.quoted.double.terraform
#          ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#            ^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                        ^ meta.interpolation.terraform punctuation.accessor.dot.terraform
#                         ^^^^^^ meta.interpolation.terraform variable.other.member.terraform
#                               ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// Template If Directives
/////////////////////////////////////////////////////////////////////

/////
// Matches if/endif directives.
/////

      "${ if name == "Mary" }${name}${ endif ~}"
#    ^ -string -punctuation
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#         ^^ meta.interpolation.terraform keyword.control.terraform
#                    ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^ source.terraform meta.interpolation.terraform string.quoted.double.terraform
#                         ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                           ^ punctuation.section.interpolation.end.terraform
#                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                  ^ punctuation.section.interpolation.end.terraform 
#                                   ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                      ^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                            ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                             ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                              ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                               ^ -string -punctuation

/////
// Matches if/else/endif directives.
/////

      "%{ if name == "Mary" }${name}%{ else }${ "Mary" }%{ endif ~}"
#    ^ -string -punctuation
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#         ^^ meta.interpolation.terraform keyword.control.terraform
#                    ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^ source.terraform meta.interpolation.terraform string.quoted.double.terraform
#                         ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                           ^ punctuation.section.interpolation.end.terraform
#                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                  ^ punctuation.section.interpolation.end.terraform 
#                                   ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                      ^^^^ meta.interpolation.terraform keyword.control.terraform
#                                           ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                               ^ meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                                ^^^^^ meta.interpolation.terraform string.quoted.double.terraform
#                                                      ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                      ^ punctuation.section.interpolation.end.terraform
#                                                       ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                                          ^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                                                ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                                                 ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                                  ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                                                   ^ -string -punctuation

/////
// Matches for/in/endfor directives.
// TODO: add checks for var.*
/////

      "%{ for name in var.names ~}${name}%{ endfor ~}"
#   ^ -string -punctuation      
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#         ^^^ keyword.control.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                  ^^ keyword.control.terraform
#                        ^ meta.interpolation.terraform punctuation.accessor.dot.terraform
#                         ^^^^^ meta.interpolation.terraform variable.other.member.terraform
#                               ^ keyword.operator.template.right.trim.terraform
#                                ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                 ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                       ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                        ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                           ^^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                                  ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                                   ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                    ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                                     ^ -string -punctuation

/////
// Handles function calls
/////

      "${formatdate("DD MMM YYYY hh:mm ZZZ", "2018-01-02T23:12:01Z")}"
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#        ^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform support.function.builtin.terraform
#                  ^ meta.interpolation.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                   ^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.interpolation.terraform meta.function-call.terraform punctuation.separator.terraform
#                                            ^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                             ^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform
#                                                                  ^ meta.interpolation.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                                   ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                                    ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// Operators
/////////////////////////////////////////////////////////////////////

/////
// Comparison
/////

    a == b
#   ^ -keyword -operator
#     ^^ keyword.operator.terraform
#         ^ -keyword -operator 

    a != b
#   ^ -keyword -operator
#     ^^ keyword.operator.terraform
#         ^ -keyword -operator 

    a < b
#    ^ -keyword -operator
#     ^ keyword.operator.terraform
#      ^ -keyword -operator

    a <= b
#    ^ -keyword -operator
#     ^^ keyword.operator.terraform
#       ^ -keyword -operator

    a > b
#    ^ -keyword -operator 
#     ^ keyword.operator.terraform
#      ^ -keyword -operator

    a >= b
#    ^ -keyword -operator
#     ^^ keyword.operator.terraform
#       ^ -keyword -operator

/////
// Arithmetic
/////

    a + b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a - b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a * b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a / b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a % b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    -a
#  ^ -keyword -operator
#   ^ keyword.operator.arithmetic.terraform 
#    ^ -keyword -operator 

/////
// Logic
/////

    a && b
#   ^^ -keyword -operator
#     ^^ keyword.operator.logical.terraform
#       ^^ -keyword -operator

    a || b
#   ^^ -keyword -operator
#     ^^ keyword.operator.logical.terraform
#       ^^ -keyword -operator

    !a
# ^^ -keyword -operator
#   ^ keyword.operator.logical.terraform
#    ^^ -keyword -operator

/////
// Conditional
/////

    length(some_list) > 0 ? some_list[0] : default
#   ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                   ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                     ^ keyword.operator.terraform
#                       ^ constant.numeric.integer.terraform
#                         ^ keyword.operator.terraform
#                                    ^ punctuation.section.brackets.begin.terraform
#                                     ^ constant.numeric.integer.terraform
#                                      ^ punctuation.section.brackets.end.terraform
#                                        ^ keyword.operator.terraform

/////
// Ellipsis
/////

    hhh([55, 2453, 2]...)
#   ^^^ meta.function-call.terraform variable.function.terraform
#      ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#       ^ punctuation.section.brackets.begin.terraform
#        ^^ constant.numeric.integer.terraform
#          ^ punctuation.separator.terraform
#            ^^^^ constant.numeric.integer.terraform
#                ^ punctuation.separator.terraform
#                  ^ constant.numeric.integer.terraform
#                   ^ punctuation.section.brackets.end.terraform
#                    ^^^ keyword.operator.terraform 
#                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////////////////////////////////////////////////////////////////////
// Brackets: Index Operations and Arrays
/////////////////////////////////////////////////////////////////////

/////
// Index Operations
/////

    thing[1]
#       ^ -punctuation 
#        ^ punctuation.section.brackets.begin.terraform
#         ^ constant.numeric.integer.terraform
#          ^ punctuation.section.brackets.end.terraform
#           ^ -punctuation

/////
// Arrays of literals
/////

    ["a", "b", "c"]
#   ^ punctuation.section.brackets.begin.terraform
#    ^ punctuation.definition.string.begin.terraform
#    ^^^ string.quoted.double.terraform
#      ^ punctuation.definition.string.end.terraform
#       ^ punctuation.separator.terraform
#         ^ punctuation.definition.string.begin.terraform
#         ^^^ string.quoted.double.terraform
#           ^ punctuation.definition.string.end.terraform
#            ^ punctuation.separator.terraform
#              ^ punctuation.definition.string.begin.terraform
#              ^^^ string.quoted.double.terraform
#                ^ punctuation.definition.string.end.terraform
#                 ^ punctuation.section.brackets.end.terraform

/////
// Allows inline comments
/////

    [1, /* inline */ 2]
#   ^ punctuation.section.brackets.begin.terraform
#    ^ constant.numeric.integer.terraform
#     ^ punctuation.separator.terraform
#       ^^ punctuation.definition.comment.terraform
#       ^^^^^^^^^^^^ comment.block.terraform
#                 ^^ punctuation.definition.comment.terraform
#                    ^ constant.numeric.integer.terraform
#                     ^ punctuation.section.brackets.end.terraform

/////
// Allows expression over multiple lines
/////

    [
#   ^ punctuation.section.brackets.begin.terraform
      1,
#     ^ constant.numeric.integer.terraform
#      ^ punctuation.separator.terraform
      2
#     ^ constant.numeric.integer.terraform
    ]
#   ^ punctuation.section.brackets.end.terraform

/////
// Allows operators
/////

    [ 1 + 2 ]
#   ^ punctuation.section.brackets.begin.terraform
#     ^ constant.numeric.integer.terraform
#       ^ keyword.operator.arithmetic.terraform
#         ^ constant.numeric.integer.terraform
#           ^ punctuation.section.brackets.end.terraform

/////
// Splat operator
/////

    tuple[*].foo.bar[0]
#        ^ punctuation.section.brackets.begin.terraform
#         ^ punctuation.section.brackets.end.terraform keyword.operator.splat.terraform
#          ^ punctuation.section.brackets.end.terraform
#           ^ punctuation.accessor.dot.terraform
#            ^^^ variable.other.member.terraform
#               ^ punctuation.accessor.dot.terraform
#                ^^^ variable.other.member.terraform
#                   ^ punctuation.section.brackets.begin.terraform
#                    ^ constant.numeric.integer.terraform
#                     ^ punctuation.section.brackets.end.terraform

/////
// Handle nested arrays
/////

    count = [
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ punctuation.section.brackets.begin.terraform
      [ 1, 2],
#     ^ punctuation.section.brackets.begin.terraform
#       ^ constant.numeric.integer.terraform
#        ^ punctuation.separator.terraform
#          ^ constant.numeric.integer.terraform
#           ^ punctuation.section.brackets.end.terraform
#            ^ punctuation.separator.terraform
      [ 6, 7]
#     ^ punctuation.section.brackets.begin.terraform
#       ^ constant.numeric.integer.terraform
#        ^ punctuation.separator.terraform
#          ^ constant.numeric.integer.terraform
#           ^ punctuation.section.brackets.end.terraform
    ]
#   ^ punctuation.section.brackets.end.terraform
#    ^ -punctuation

/////
// Attribute-access inside arrays
/////

    [ aws_instance.ubuntu, aws_instance.freebsd ]
#   ^ punctuation.section.brackets.begin.terraform
#                 ^ punctuation.accessor.dot.terraform
#                  ^^^^^^ variable.other.member.terraform
#                        ^ punctuation.separator.terraform
#                                      ^ punctuation.accessor.dot.terraform
#                                       ^^^^^^^ variable.other.member.terraform
#                                               ^ punctuation.section.brackets.end.terraform

/////////////////////////////////////////////////////////////////////
// Attribute Access
/////////////////////////////////////////////////////////////////////

/////
// Matches dot-access
/////

    aws_instance.ubuntu[*].private_dns
#               ^ punctuation.accessor.dot.terraform
#                ^^^^^^ variable.other.member.terraform
#                      ^ punctuation.section.brackets.begin.terraform
#                       ^ punctuation.section.brackets.end.terraform keyword.operator.splat.terraform
#                        ^ punctuation.section.brackets.end.terraform
#                         ^ punctuation.accessor.dot.terraform
#                          ^^^^^^^^^^^ variable.other.member.terraform
#                                     ^ -variable -punctuation 

/////
// Ignores dot-access in string literals
/////

    "aws_instance.ubuntu"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^ -variable
#   ^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.terraform

/////
// Matches inside for-expressions
/////

   [for l in var.letters: upper(l)]
#  ^ punctuation.section.brackets.begin.terraform
#   ^^^ keyword.control.terraform
#       ^ variable.other.readwrite.terraform
#         ^^ keyword.operator.word.terraform
#            ^^^ variable.other.readwrite.terraform
#               ^ punctuation.accessor.dot.terraform
#                ^^^^^^^ variable.other.member.terraform
#                       ^ keyword.operator.terraform
#                         ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                               ^ meta.function-call.terraform variable.parameter.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                 ^ punctuation.section.brackets.end.terraform

/////
// Attribute-only splat
/////

    tuple.*.foo.bar[0]
#        ^ punctuation.accessor.dot.terraform
#         ^ keyword.operator.splat.terraform
#          ^ punctuation.accessor.dot.terraform
#           ^^^ variable.other.member.terraform
#              ^ punctuation.accessor.dot.terraform
#               ^^^ variable.other.member.terraform
#                  ^ punctuation.section.brackets.begin.terraform
#                   ^ constant.numeric.integer.terraform
#                    ^ punctuation.section.brackets.end.terraform

/////////////////////////////////////////////////////////////////////
// Attribute Definition
/////////////////////////////////////////////////////////////////////

/////
// Basic definition
// TODO: match var keyword
/////

    count = length(var.availability_zones)
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^^^ meta.function-call.terraform variable.parameter.terraform
#                     ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                      ^^^^^^^^^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Populate an attribute from a variable value
/////

    (foo) = "baz"
#   ^ variable.declaration.terraform punctuation.section.parens.begin.terraform
#    ^^^ variable.declaration.terraform variable.other.readwrite.terraform
#       ^ variable.declaration.terraform punctuation.section.parens.end.terraform
#         ^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^^^^ string.quoted.double.terraform
#               ^ string.quoted.double.terraform punctuation.definition.string.end.terraform 

/////////////////////////////////////////////////////////////////////
// Function Calls
// TODO: object literals as parameters
/////////////////////////////////////////////////////////////////////


/////
// Basic call
/////

    thing(l)
#   ^^^^^ meta.function-call.terraform variable.function.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform variable.parameter.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Matches parameters, attribute-access, literals, operators, commas
/////

    cidrthingy(aws_vpc.main.cidr_block, 4, count.index+1)
#   ^^^^^^^^^^ meta.function-call.terraform variable.function.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                     ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                      ^^^^ meta.function-call.terraform variable.other.member.terraform
#                          ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                           ^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                     ^ meta.function-call.terraform punctuation.separator.terraform
#                                       ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                        ^ meta.function-call.terraform punctuation.separator.terraform
#                                          ^^^^^ meta.function-call.terraform variable.parameter.terraform
#                                               ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                                                ^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                                     ^ meta.function-call.terraform keyword.operator.arithmetic.terraform
#                                                      ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                        ^ -meta -function-call -variable

/////
// Matches arrays and splat
/////

      y6y([55, 2453, 2]..., [55555555])
#     ^^^ meta.function-call.terraform variable.function.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#          ^^ meta.function-call.terraform constant.numeric.integer.terraform
#            ^ meta.function-call.terraform punctuation.separator.terraform
#              ^^^^ meta.function-call.terraform constant.numeric.integer.terraform
#                  ^ meta.function-call.terraform punctuation.separator.terraform
#                    ^ meta.function-call.terraform constant.numeric.integer.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                      ^^^ meta.function-call.terraform keyword.operator.terraform
#                         ^ meta.function-call.terraform punctuation.separator.terraform
#                           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                            ^^^^^^^^ meta.function-call.terraform constant.numeric.integer.terraform
#                                    ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Matche nested function calls.
/////

    func(thing(yep(1)))
#   ^^^^ meta.function-call.terraform variable.function.terraform
#       ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#        ^^^^^ meta.function-call.terraform meta.function-call.terraform variable.function.terraform
#             ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^^^ meta.function-call.terraform meta.function-call.terraform meta.function-call.terraform variable.function.terraform
#                 ^ meta.function-call.terraform meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform meta.function-call.terraform meta.function-call.terraform constant.numeric.integer.terraform
#                   ^ meta.function-call.terraform meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                    ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                      ^ -function

/////////////////////////////////////////////////////////////////////
// Built-in Terraform Functions
// TODO: match % placeholders in format()-family first parameters
// TODO: match regexs in regex()-family first parameters
////////////////////////`/////////////////////////////////////////////

/////
// Numeric Functions
/////

      abs(23)
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^^ meta.function-call.terraform constant.numeric.integer.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      ceil(5.1)
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^^^ meta.function-call.terraform constant.numeric.float.terraform
#           ^ meta.function-call.terraform constant.numeric.float.terraform punctuation.separator.decimal.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      floor(5)
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform constant.numeric.integer.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      log(50, 10)
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^^ meta.function-call.terraform constant.numeric.integer.terraform
#           ^ meta.function-call.terraform punctuation.separator.terraform
#             ^^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      max(12, 54, 3)
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^^ meta.function-call.terraform constant.numeric.integer.terraform
#           ^ meta.function-call.terraform punctuation.separator.terraform
#             ^^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.separator.terraform
#                 ^ meta.function-call.terraform constant.numeric.integer.terraform
#                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      min(12, 54, 3)
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^^ meta.function-call.terraform constant.numeric.integer.terraform
#           ^ meta.function-call.terraform punctuation.separator.terraform
#             ^^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.separator.terraform
#                 ^ meta.function-call.terraform constant.numeric.integer.terraform
#                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      pow(3, 2)
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform constant.numeric.integer.terraform
#          ^ meta.function-call.terraform punctuation.separator.terraform
#            ^ meta.function-call.terraform constant.numeric.integer.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      signum(-13)
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform keyword.operator.arithmetic.terraform
#             ^^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// String Functions
/////

      chomp("hello\n")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^^ meta.function-call.terraform string.quoted.double.terraform constant.character.escape.terraform
#                   ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      format("Hello, %s!", "Ander")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                        ^ meta.function-call.terraform punctuation.separator.terraform
#                          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                           ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      formatlist("Hello, %s!", ["Valentina", "Ander"])
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform punctuation.separator.terraform
#                              ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                ^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.function-call.terraform punctuation.separator.terraform
#                                            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                             ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                   ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      indent(2, "[\n  foo,\n  bar,\n]\n")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform constant.numeric.integer.terraform
#             ^ meta.function-call.terraform punctuation.separator.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      join(", ", ["foo", "bar", "baz"])
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^^ meta.function-call.terraform string.quoted.double.terraform
#              ^ meta.function-call.terraform punctuation.separator.terraform
#                ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                 ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.separator.terraform
#                        ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                         ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                             ^ meta.function-call.terraform punctuation.separator.terraform
#                               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                    ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform
 
      lower("HELLO")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      regex("[a-z]+", "53453453.345345aaabbbccc23454")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      regexall("[a-z]+", "1234abcd5678efgh9")
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.separator.terraform
#                        ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                         ^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform
 
      replace("1 + 2 + 3", "+", "-")
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                        ^ meta.function-call.terraform punctuation.separator.terraform
#                          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                           ^^ meta.function-call.terraform string.quoted.double.terraform
#                             ^ meta.function-call.terraform punctuation.separator.terraform
#                               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                ^^ meta.function-call.terraform string.quoted.double.terraform
#                                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      split(",", "foo")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^ meta.function-call.terraform string.quoted.double.terraform
#              ^ meta.function-call.terraform punctuation.separator.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      strrev("hello")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                   ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      substr("🤔🤷", 0, 1)
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^ meta.function-call.terraform string.quoted.double.terraform
#                ^ meta.function-call.terraform punctuation.separator.terraform
#                  ^ meta.function-call.terraform constant.numeric.integer.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^ meta.function-call.terraform constant.numeric.integer.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      title("hello world")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      trimspace("  hello\n\n")
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      upper("hello")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Collection Functions
/////

      chunklist(["a", "b"], 2)
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                ^^^ meta.function-call.terraform string.quoted.double.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^^^ meta.function-call.terraform string.quoted.double.terraform
#                        ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                         ^ meta.function-call.terraform punctuation.separator.terraform
#                           ^ meta.function-call.terraform constant.numeric.integer.terraform
#                            ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      coalesce("a", "b")
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^ meta.function-call.terraform punctuation.separator.terraform
#                   ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      coalescelist([], ["c", "d"])
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                   ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                    ^ meta.function-call.terraform punctuation.separator.terraform
#                      ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                       ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                        ^^ meta.function-call.terraform string.quoted.double.terraform
#                          ^ meta.function-call.terraform punctuation.separator.terraform
#                            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                             ^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      compact(["a", "", "b"])
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^ meta.function-call.terraform punctuation.separator.terraform
#                   ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                     ^ meta.function-call.terraform punctuation.separator.terraform
#                       ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                        ^^ meta.function-call.terraform string.quoted.double.terraform
#                          ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      concat(["a"], ["c"])
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^ meta.function-call.terraform string.quoted.double.terraform
#                ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                 ^ meta.function-call.terraform punctuation.separator.terraform
#                   ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                    ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                     ^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform
 
      contains(["a"], "a")
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                      ^^ meta.function-call.terraform string.quoted.double.terraform
#                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      distinct(["a", "b", "a"])
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.separator.terraform
#                    ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                     ^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform punctuation.separator.terraform
#                         ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                          ^^ meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      element(["a", "b"], 1)
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^ meta.function-call.terraform punctuation.separator.terraform
#                   ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                       ^ meta.function-call.terraform punctuation.separator.terraform
#                         ^ meta.function-call.terraform constant.numeric.integer.terraform
#                          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      flatten([[["a", "b"]], ["c"]])
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^^^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^ meta.function-call.terraform string.quoted.double.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                      ^^ meta.function-call.terraform string.quoted.double.terraform
#                        ^^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                          ^ meta.function-call.terraform punctuation.separator.terraform
#                            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                              ^^ meta.function-call.terraform string.quoted.double.terraform
#                                ^^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      index(["a"], "b")
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^ meta.function-call.terraform string.quoted.double.terraform
#               ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                ^ meta.function-call.terraform punctuation.separator.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^ meta.function-call.terraform string.quoted.double.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      keys({a=1, c=2, d=3})
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                         ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      length([])
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#             ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      list("a", "b", "c")
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^ meta.function-call.terraform string.quoted.double.terraform
#             ^ meta.function-call.terraform punctuation.separator.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.separator.terraform
#                    ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                     ^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      lookup({a="ay", b="bee"}, "a", "what?")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      map("a", "b")
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#          ^^ meta.function-call.terraform string.quoted.double.terraform
#            ^ meta.function-call.terraform punctuation.separator.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      matchkeys(["i-123", "i-abc"], ["us-west", "us-east"], ["us-east"])
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform punctuation.separator.terraform
#                         ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                          ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                 ^ meta.function-call.terraform punctuation.separator.terraform
#                                   ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                                    ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                     ^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                             ^ meta.function-call.terraform punctuation.separator.terraform
#                                               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                                ^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                        ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                                         ^ meta.function-call.terraform punctuation.separator.terraform
#                                                           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                                                            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                                             ^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                                     ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                                                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      merge({"a"="b", "c"="d"}, {"e"="f", "c"="z"})
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                                                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform 

      range(1, 4)
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform constant.numeric.integer.terraform
#            ^ meta.function-call.terraform punctuation.separator.terraform
#              ^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      reverse([1, 2, 3])
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#              ^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.separator.terraform
#                 ^ meta.function-call.terraform constant.numeric.integer.terraform
#                  ^ meta.function-call.terraform punctuation.separator.terraform
#                    ^ meta.function-call.terraform constant.numeric.integer.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      setintersection(["a", "b"], ["b", "c"])
#     ^^^^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                    ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                      ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                       ^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.separator.terraform
#                           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                            ^^ meta.function-call.terraform string.quoted.double.terraform
#                              ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                               ^ meta.function-call.terraform punctuation.separator.terraform
#                                 ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                   ^^ meta.function-call.terraform string.quoted.double.terraform
#                                     ^ meta.function-call.terraform punctuation.separator.terraform
#                                       ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                        ^^ meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      setproduct(["development"], ["app1", "app2"])
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                 ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                              ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                               ^ meta.function-call.terraform punctuation.separator.terraform
#                                 ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                   ^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                        ^ meta.function-call.terraform punctuation.separator.terraform
#                                          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                           ^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      setunion(["a"], ["b"], ["d"])
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^ meta.function-call.terraform string.quoted.double.terraform
#                  ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                   ^ meta.function-call.terraform punctuation.separator.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                      ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                       ^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                          ^ meta.function-call.terraform punctuation.separator.terraform
#                            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                              ^^ meta.function-call.terraform string.quoted.double.terraform
#                                ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      slice(["a", "b"], 1, 1)
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^ meta.function-call.terraform string.quoted.double.terraform
#               ^ meta.function-call.terraform punctuation.separator.terraform
#                 ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^ meta.function-call.terraform string.quoted.double.terraform
#                    ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                     ^ meta.function-call.terraform punctuation.separator.terraform
#                       ^ meta.function-call.terraform constant.numeric.integer.terraform
#                        ^ meta.function-call.terraform punctuation.separator.terraform
#                          ^ meta.function-call.terraform constant.numeric.integer.terraform
#                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform
      sort(["e", "d"])
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#           ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#            ^^ meta.function-call.terraform string.quoted.double.terraform
#              ^ meta.function-call.terraform punctuation.separator.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^ meta.function-call.terraform string.quoted.double.terraform
#                   ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      transpose({"a" = ["1", "2"], "b" = ["2", "3"]})
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                                                   ^ meta.function-call.terraform punctuation.section.parens.end.terraform 

/////
// TODO: match map literal
/////

      values({a=3, c=2, d=1})
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      zipmap(["a", "b"], [1, 2])
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^ meta.function-call.terraform string.quoted.double.terraform
#                ^ meta.function-call.terraform punctuation.separator.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^ meta.function-call.terraform string.quoted.double.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                      ^ meta.function-call.terraform punctuation.separator.terraform
#                        ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                         ^ meta.function-call.terraform constant.numeric.integer.terraform
#                          ^ meta.function-call.terraform punctuation.separator.terraform
#                            ^ meta.function-call.terraform constant.numeric.integer.terraform
#                             ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                              ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Encoding Functions
/////

      base64decode("SGVsbG8gV29ybGQ=")
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      base64encode("Hello World")
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      base64gzip("Hello World")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      csvdecode("a,b,c\n1,2,3\n4,5,6")
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      jsondecode("{\"hello\": \"world\"}")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      jsonencode({"hello"="world"})
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                                 ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      urlencode("Hello World")
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      yamldecode("true")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literal
/////

      yamlencode({"a":"b", "c":"d"})
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Filesystem Functions
/////

/////
// TODO: match built-in variables
/////

      abspath(path.root)
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^^^^ meta.function-call.terraform variable.parameter.terraform
#                 ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                  ^^^^ meta.function-call.terraform variable.other.member.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      dirname("foo/bar/baz.txt")
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                              ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      pathexpand("~/.ssh/id_rsa")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      basename("foo/bar/baz.txt")
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match built-in variables
/////

      file("${path.module}/hello.txt")
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^ meta.function-call.terraform meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#             ^^^^^^^^^^^^ meta.function-call.terraform meta.interpolation.terraform
#                         ^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                    ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match built-in variables
/////

      fileexists("${path.module}/hello.txt")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^ meta.function-call.terraform meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                   ^^^^^^^^^^^^ meta.function-call.terraform meta.interpolation.terraform
#                               ^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match built-in variables
/////

      fileset(path.module, "files/*.txt")
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^^^^ meta.function-call.terraform variable.parameter.terraform
#                 ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                  ^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                        ^ meta.function-call.terraform punctuation.separator.terraform
#                          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                           ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match built-in variables
/////

      filebase64("${path.module}/hello.txt")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^ meta.function-call.terraform meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                   ^^^^^^^^^^^^ meta.function-call.terraform meta.interpolation.terraform
#                               ^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match built-in variables
// TODO: match map literal
/////

      templatefile("${path.module}/backends.tmpl", {
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^ meta.function-call.terraform meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                     ^^^^^^^^^^^^ meta.function-call.terraform meta.interpolation.terraform
#                                 ^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                ^ meta.function-call.terraform punctuation.separator.terraform
#                                                  ^^ meta.function-call.terraform
        port = 8080,
#       ^^^^ meta.function-call.terraform variable.parameter.terraform
#^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
        ip_addrs = ["10.0.0.1", "10.0.0.2"]
#       ^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
      })
#^^^^^^^ meta.function-call.terraform
#      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Date & Time Functions
/////

      formatdate("DD MMM YYYY hh:mm ZZZ", "2018-01-02T23:12:01Z")
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                       ^ meta.function-call.terraform punctuation.separator.terraform
#                                         ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                          ^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform
 
      timeadd("2017-11-22T00:00:00Z", "10m")
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                   ^ meta.function-call.terraform punctuation.separator.terraform
#                                     ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                      ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      timestamp()
#     ^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Hash & Crypto Functions
/////

      base64sha256("hello world")
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      base64sha512("hello world")
#     ^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      bcrypt("hello world")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      filebase64sha256(file("filename"))
#     ^^^^^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                      ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                          ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                           ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                            ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                                     ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                       ^ -function

      filebase64sha512(file("filename"))
#     ^^^^^^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                      ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                          ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                           ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                            ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                                     ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                       ^ -function

      filemd5(file("filename"))
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      filemd1(file("filename"))
#     ^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#             ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                 ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                            ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                              ^ -function

      filesha256(file("filename"))
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                    ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                     ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                      ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                 ^ -function

      filesha512(file("filename"))
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                    ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                     ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                      ^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                 ^ -function
 
      md5("hello world")
#     ^^^ meta.function-call.terraform support.function.builtin.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#          ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                      ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: Match builtin variables
/////

      rsadecrypt(filebase64("${path.module}/ciphertext"), file("privatekey.pem"))
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                          ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                           ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                            ^^ meta.function-call.terraform meta.function-call.terraform meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                              ^^^^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform meta.interpolation.terraform
#                                          ^^^^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                                                      ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                       ^ meta.function-call.terraform punctuation.separator.terraform
#                                                         ^^^^ meta.function-call.terraform meta.function-call.terraform support.function.builtin.terraform
#                                                             ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                                                              ^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                                               ^^^^^^^^^^^^^^^ meta.function-call.terraform meta.function-call.terraform string.quoted.double.terraform
#                                                                              ^ meta.function-call.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                                                ^ -function

      sha1("hello world")
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      sha256("hello world")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      sha512("hello world")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      uuid()
#     ^^^^ meta.function-call.terraform support.function.builtin.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      uuidv5("dns", "www.terraform.io")
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^^^ meta.function-call.terraform string.quoted.double.terraform
#                 ^ meta.function-call.terraform punctuation.separator.terraform
#                   ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// IP Network Functions
/////

      cidrhost("10.12.127.0/20", 16)
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                              ^ meta.function-call.terraform punctuation.separator.terraform
#                                ^^ meta.function-call.terraform constant.numeric.integer.terraform
#                                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      cidrnetmask("172.16.0.0/12")
#     ^^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                 ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      cidrsubnet("172.16.0.0/12", 4, 2)
#     ^^^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                 ^^^^^^^^^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                               ^ meta.function-call.terraform punctuation.separator.terraform
#                                 ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                  ^ meta.function-call.terraform punctuation.separator.terraform
#                                    ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Type Conversions Functions
/////

      tobool(true)
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^^^^ meta.function-call.terraform constant.language.terraform
#                ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      tolist(["a", "b", "c"])
#     ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#           ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#            ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#             ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#              ^^ meta.function-call.terraform string.quoted.double.terraform
#                ^ meta.function-call.terraform punctuation.separator.terraform
#                  ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                   ^^ meta.function-call.terraform string.quoted.double.terraform
#                     ^ meta.function-call.terraform punctuation.separator.terraform
#                       ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                        ^^ meta.function-call.terraform string.quoted.double.terraform
#                          ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                           ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// TODO: match map literals
/////

      tomap({"a" = 1, "b" = 2})
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^^^^^^^^^^^^^^^^^^^ meta.function-call.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      tonumber(1)
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform constant.numeric.integer.terraform
#               ^ meta.function-call.terraform punctuation.section.parens.end.terraform
 
      toset(["a", "b", "c"])
#     ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#            ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#             ^^ meta.function-call.terraform string.quoted.double.terraform
#               ^ meta.function-call.terraform punctuation.separator.terraform
#                 ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                  ^^ meta.function-call.terraform string.quoted.double.terraform
#                    ^ meta.function-call.terraform punctuation.separator.terraform
#                      ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                       ^^ meta.function-call.terraform string.quoted.double.terraform
#                         ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

      tostring("hello")
#     ^^^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^ meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#               ^^^^^^ meta.function-call.terraform string.quoted.double.terraform
#                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////////////////////////////////////////////////////////////////////
// TUPLE FOR-EXPRESSIONS
/////////////////////////////////////////////////////////////////////

/////
// Basic expression.
// TODO: match "var" keyword
/////

    [for s in var.list : upper(s)]
#   ^ punctuation.section.brackets.begin.terraform
#    ^^^ keyword.control.terraform
#        ^ variable.other.readwrite.terraform
#          ^^ keyword.operator.word.terraform
#             ^^^ variable.other.readwrite.terraform
#                ^ punctuation.accessor.dot.terraform
#                 ^^^^ variable.other.member.terraform
#                      ^ keyword.operator.terraform
#                        ^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                              ^ meta.function-call.terraform variable.parameter.terraform
#                               ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                ^ punctuation.section.brackets.end.terraform

/////
// Object or map source value.
// TODO: match "var" keyword
////

    [for k, v in var.map : length(k) + length(v)]
#   ^ punctuation.section.brackets.begin.terraform
#    ^^^ keyword.control.terraform
#        ^ variable.other.readwrite.terraform
#         ^ punctuation.separator.terraform
#           ^ variable.other.readwrite.terraform
#             ^^ keyword.operator.word.terraform
#                ^^^ variable.other.readwrite.terraform
#                   ^ punctuation.accessor.dot.terraform
#                    ^^^ variable.other.member.terraform
#                        ^ keyword.operator.terraform
#                          ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                                 ^ meta.function-call.terraform variable.parameter.terraform
#                                  ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                    ^ keyword.operator.arithmetic.terraform
#                                      ^^^^^^ meta.function-call.terraform support.function.builtin.terraform
#                                            ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                                             ^ meta.function-call.terraform variable.parameter.terraform
#                                              ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                               ^ punctuation.section.brackets.end.terraform

/////
// Complex right-side expressions.
// TODO: match "var" keyword
////

    [for o in var.list : o.interfaces[0].name]
#   ^ punctuation.section.brackets.begin.terraform
#    ^^^ keyword.control.terraform
#        ^ variable.other.readwrite.terraform
#          ^^ keyword.operator.word.terraform
#             ^^^ variable.other.readwrite.terraform
#                ^ punctuation.accessor.dot.terraform
#                 ^^^^ variable.other.member.terraform
#                      ^ keyword.operator.terraform
#                        ^ variable.other.readwrite.terraform
#                         ^ punctuation.accessor.dot.terraform
#                          ^^^^^^^^^^ variable.other.member.terraform
#                                    ^ punctuation.section.brackets.begin.terraform
#                                     ^ constant.numeric.integer.terraform
#                                      ^ punctuation.section.brackets.end.terraform
#                                       ^ punctuation.accessor.dot.terraform
#                                        ^^^^ variable.other.member.terraform
#                                            ^ punctuation.section.brackets.end.terraform

/////
// Legacy splat expression attribute access.
// TODO: match "var" keyword
/////

    [for o in var.list : o.interfaces][0].name
#   ^ punctuation.section.brackets.begin.terraform
#    ^^^ keyword.control.terraform
#        ^ variable.other.readwrite.terraform
#          ^^ keyword.operator.word.terraform
#             ^^^ variable.other.readwrite.terraform
#                ^ punctuation.accessor.dot.terraform
#                 ^^^^ variable.other.member.terraform
#                      ^ keyword.operator.terraform
#                        ^ variable.other.readwrite.terraform
#                         ^ punctuation.accessor.dot.terraform
#                          ^^^^^^^^^^ variable.other.member.terraform
#                                    ^ punctuation.section.brackets.end.terraform
#                                     ^ punctuation.section.brackets.begin.terraform
#                                      ^ constant.numeric.integer.terraform
#                                       ^ punctuation.section.brackets.end.terraform
#                                        ^ punctuation.accessor.dot.terraform
#                                         ^^^^ variable.other.member.terraform

/////
// Multi-line for-expressions.
/////

    value = [
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ punctuation.section.brackets.begin.terraform
      for instance in aws_instance.ubuntu:
#     ^^^ keyword.control.terraform
#         ^^^^^^^^ variable.other.readwrite.terraform
#                  ^^ keyword.operator.word.terraform
#                     ^^^^^^^^^^^^ variable.other.readwrite.terraform
#                                 ^ punctuation.accessor.dot.terraform
#                                  ^^^^^^ variable.other.member.terraform
#                                        ^ keyword.operator.terraform
      instance.private_dns
#     ^^^^^^^^ variable.other.readwrite.terraform
#             ^ punctuation.accessor.dot.terraform
#              ^^^^^^^^^^^ variable.other.member.terraform
    ]
#   ^ punctuation.section.brackets.end.terraform

/////
// Match conditional on right-side expression.
// TODO: match parenthesis
/////

    value = [
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ punctuation.section.brackets.begin.terraform
      for instance in aws_instance.ubuntu:
#     ^^^ keyword.control.terraform
#         ^^^^^^^^ variable.other.readwrite.terraform
#                  ^^ keyword.operator.word.terraform
#                     ^^^^^^^^^^^^ variable.other.readwrite.terraform
#                                 ^ punctuation.accessor.dot.terraform
#                                  ^^^^^^ variable.other.member.terraform
#                                        ^ keyword.operator.terraform 
      (instance.public_ip != "" ? list(instance.private_ip, instance.public_ip) : list(instance.private_ip))
#      ^^^^^^^^ variable.other.readwrite.terraform
#              ^ punctuation.accessor.dot.terraform
#               ^^^^^^^^^ variable.other.member.terraform
#                         ^^ keyword.operator.terraform
#                            ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                             ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                               ^ keyword.operator.terraform
#                                 ^^^^ meta.function-call.terraform support.function.builtin.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                                      ^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                                              ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                                               ^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                                         ^ meta.function-call.terraform punctuation.separator.terraform
#                                                           ^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                                                                   ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                                                                    ^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                                                             ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                                               ^ keyword.operator.terraform
#                                                                                 ^^^^ meta.function-call.terraform support.function.builtin.terraform
#                                                                                     ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                                                                                      ^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                                                                                              ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                                                                                               ^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                                                                                         ^ meta.function-call.terraform punctuation.section.parens.end.terraform 
    ]
#   ^ punctuation.section.brackets.end.terraform

/////
// Match brackets on right-side expression.
// TODO: match parenthesis
/////

    value = [
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ punctuation.section.brackets.begin.terraform 
      for instance in aws_instance.ubuntu:
#     ^^^ keyword.control.terraform
#         ^^^^^^^^ variable.other.readwrite.terraform
#                  ^^ keyword.operator.word.terraform
#                     ^^^^^^^^^^^^ variable.other.readwrite.terraform
#                                 ^ punctuation.accessor.dot.terraform
#                                  ^^^^^^ variable.other.member.terraform
#                                        ^ keyword.operator.terraform 
      (instance.public_ip != "" ? [instance.private_ip, instance.public_ip] : [instance.private_ip])
#      ^^^^^^^^ variable.other.readwrite.terraform
#              ^ punctuation.accessor.dot.terraform
#               ^^^^^^^^^ variable.other.member.terraform
#                         ^^ keyword.operator.terraform
#                            ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                             ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                               ^ keyword.operator.terraform
#                                 ^ punctuation.section.brackets.begin.terraform
#                                          ^ punctuation.accessor.dot.terraform
#                                           ^^^^^^^^^^ variable.other.member.terraform
#                                                     ^ punctuation.separator.terraform
#                                                               ^ punctuation.accessor.dot.terraform 
#                                                                ^^^^^^^^^ variable.other.member.terraform  
#                                                                         ^ punctuation.section.brackets.end.terraform
#                                                                           ^ keyword.operator.terraform
#                                                                             ^ punctuation.section.brackets.begin.terraform
#                                                                                      ^ punctuation.accessor.dot.terraform
#                                                                                       ^^^^^^^^^^ variable.other.member.terraform
#                                                                                                 ^ punctuation.section.brackets.end.terraform  
    ]
#   ^ punctuation.section.brackets.end.terraform
