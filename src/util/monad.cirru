
-- ":not but learnt from Monad"

= exports.bind $ \ (x k)
  k x

= exports.trace $ \ (x k)
  console.log x k
  return k
