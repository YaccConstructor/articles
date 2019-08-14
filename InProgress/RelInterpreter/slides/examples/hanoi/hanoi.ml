open GT
open MiniKanren
open MiniKanrenStd
   
@type pin = A | B | C with show

let rec eval c = function
| [] -> c
| (f, t) :: moves' ->
   let top :: rest = List.assoc f c in
   let pin_t =
     match List.assoc t c with
     | []                                 -> [top]
     | top' :: _ as pin_t when top < top' -> top :: pin_t
   in
   eval ((f, rest) :: (t, pin_t) :: c) moves'

let show_pins c =
  Printf.sprintf "(%s, %s, %s)"
    (show(GT.list) (show(int)) @@ List.assoc A c)
    (show(GT.list) (show(int)) @@ List.assoc B c)
    (show(GT.list) (show(int)) @@ List.assoc C c)

let _ =
  let c0 = [(A, [1; 2; 3]); (B, []); (C, [])] in
  let c1 = eval c0 [(A, B); (A, C); (B, C); (A, B); (C, A); (C, B); (A, B)] in
  Printf.printf "%s -> %s\n%!" (show_pins c0) (show_pins c1) 
   
let rec evalo c moves c' =
  conde [
    moves === nil () &&& (c === c');
    fresh (f t moves' pin_f pin_t) (
      ?& [moves === (pair f t) % moves';
          List.assoco f c pin_f;
          List.assoco t c pin_t;
          fresh (ftop frest c'') (
           ?& [evalo c'' moves' c';
               pin_f === ftop % frest;
               conde [
                 c'' === (pair f frest) % ((pair t (!< ftop)) % c) &&& (pin_t === nil ());
                 fresh (ttop trest) (
                   ?& [pin_t === ttop % trest;
                       Nat.lto ftop ttop Bool.truo;
                       c'' === (pair f frest) % ((pair t trest) % c);
                 ]);                 
               ];
             ]
          );
        ]
    )
  ]

let show_pins' c =
  show(List.logic) (show(Pair.logic) (show(logic) (show(pin))) (show(List.logic) (show(Nat.logic)))) c
(*
let _ =
  List.iter (fun c -> Printf.printf "%s\n%!" @@ show_pins' @@ c#reify (List.reify (Pair.reify reify (List.reify Nat.reify)))) @@ Stream.take @@
  run q
    (fun c -> evalo ((pair (!!A) ((nat 1) % ((nat 2) %< (nat 3)))) % ((pair (!!B) (nil ())) %< (pair (!!C) (nil ())))) (!< (pair (!!A) (!!C))) c)
    (fun c -> c)
 *)
let _ =
  List.iter (fun c -> Printf.printf "%s\n%!" @@ show(List.logic) (show(Pair.logic) (show(logic) (show(pin))) (show(logic) (show(pin)))) @@
                        c#reify (List.reify (Pair.reify reify reify))) @@ Stream.take ~n:1 @@
  run q
    (fun c ->
      fresh (c') (
        (evalo
          ((pair (!!A) (!< (nat 1) )) % ((pair (!!B) (nil ())) %< (pair (!!C) (nil ()))))
          c
          c'
      )
      &&&
      (List.assoco (!!A) c' (nil ())) &&&
      (List.assoco (!!C) c' (nil ())) &&&
      (List.assoco (!!B) c' (!< (nat 1) )))
    )
    (fun c -> c)
(*
  run q
    (fun c ->
      fresh (c') (
      (evalo
        ((pair (!!A) ((nat 1) % ((nat 2) %< (nat 3)))) % ((pair (!!B) (nil ())) %< (pair (!!C) (nil ()))))
        c
        c'
      )
      &&&
      (List.assoco (!!A) c' (nil ())) &&&
      (List.assoco (!!C) c' (nil ())) &&&
      (List.assoco (!!B) c' ((nat 1) % ((nat 2) %< (nat 3)))))
    )
    (fun c -> c)
 *)
