name "chap4"
description "Chapter 4 Role"
run_list(
  "recipe[git]",
  "recipe[chruby::system]",
  "recipe[irc]"
)
default_attributes(
  "chruby" => {
    "rubies" => {
      "1.9.3-p392" => false,
      "1.9.3-p551" => true
    },
    "default" => "1.9.3-p551"
  }
)
