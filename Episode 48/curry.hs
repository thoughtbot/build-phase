-- Curried function that adds the provided number to 2 + would normally be
-- called as an infix operator, but for this purpose, we'll call it as a normal
-- function by wrapping it in parens.
addTwo :: Integer -> Integer
addTwo = (+) 2

main = do
  println $ (+) 2 3 -- prints 5
  println $ addTwo 3 -- prints 5
