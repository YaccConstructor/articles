open MiniKanren
open GT

@type ('a, 'b) fa =
| And of 'a * 'a
| Or  of 'a * 'a
| Not of 'a
| Var of 'b with show, gmap

@type f = (f, string logic) fa logic with show, gmap
