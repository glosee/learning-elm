-- IF STATEMENTS


if True then "yes" else "not yes" -- "yes"

-- Elm doesn't understand "truthy" ("some string" !== true)
if "some value" then "yes" else "not yes" -- "not yes"


-- FUNCTIONS


-- Named functions
isPositiveInt: Int -> Bool
isPositiveInt n =
  n > 0
isPositiveInt 4 -- True


caughtThemAll pokedexCount =
  if pokedexCount == 150 then "You are a pokemaster!" else "Gotta catch 'em all!"


makeLoud: String -> String
makeLoud s =
  s ++ "!"


-- Anonymous function
(\n -> n > 0) -4 -- FALSE


-- LISTS


-- All elements must have the same type

fruits = [ "banana", "apple", "orange" ]
List.isEmpty fruits -- False
List.length fruits -- 3
List.map makeLoud fruits -- [ "banana!", "apple!", "orange!" ]

-- RECORDS (objects)

obj = { foo = "bar", baz = "bat" }
{ obj | baz = "baz" } -- { foo = "bar", baz = "baz" }

-- Destructuring in functions
octogenarian: Record -> Bool
octogenarian {age} =
  age > 79

octogenarian { name = "Grandpa", age = 87 } -- True
