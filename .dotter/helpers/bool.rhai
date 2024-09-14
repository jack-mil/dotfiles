# [helpers]
# bool = ".dotter/helpers/bool.rhai"
#
# use like this:
# bool <my_condition>
if params[0] == true || params[0] == "true" {
  "true"
}