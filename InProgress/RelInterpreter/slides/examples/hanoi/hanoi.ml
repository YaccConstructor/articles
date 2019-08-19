module L = List
         
open GT
open OCanren
open OCanren.Std
   
@type pin = A | B | C with show

let rec eval c = function
| [] -> c
| (f, t) :: moves' ->
   let top :: rest = L.assoc f c in
   let pin_t =
     match L.assoc t c with
     | []                                 -> [top]
     | top' :: _ as pin_t when top < top' -> top :: pin_t
   in
   eval ((f, rest) :: (t, pin_t) :: c) moves'

let show_pins c =
  Printf.sprintf "(%s, %s, %s)"
    (show(GT.list) (show(int)) @@ L.assoc A c)
    (show(GT.list) (show(int)) @@ L.assoc B c)
    (show(GT.list) (show(int)) @@ L.assoc C c)

let _ =
  let c0 = [(A, [1; 2; 3]); (B, []); (C, [])] in
  let c1 = eval c0 [(A, B); (A, C); (B, C); (A, B); (C, A); (C, B); (A, B)] in
  Printf.printf "%s -> %s\n%!" (show_pins c0) (show_pins c1) 

let rec eval_pins' a b c moves a' b' c' = ocanren (
 (moves == [] & a == a' & b == b' & c == c') |
 fresh f, t, moves', pin_f, pin_t, pin_f_res, pin_t_res, a'', b'', c'' in
   moves == (f, t) :: moves' &
   ((f == A & t == B & pin_f == a & pin_f_res == a'' & pin_t == b & pin_t_res == b'' & c'' == c) | 
    (f == A & t == C & pin_f == a & pin_f_res == a'' & pin_t == c & pin_t_res == c'' & b'' == b) |
    (f == B & t == A & pin_f == b & pin_f_res == b'' & pin_t == a & pin_t_res == a'' & c'' == c) |
    (f == B & t == C & pin_f == b & pin_f_res == b'' & pin_t == c & pin_t_res == c'' & a'' == a) |
    (f == C & t == A & pin_f == c & pin_f_res == c'' & pin_t == a & pin_t_res == a'' & b'' == b) |
    (f == C & t == B & pin_f == c & pin_f_res == c'' & pin_t == b & pin_t_res == b'' & a'' == a)) &    
   fresh top_f, rest_f in
     pin_f == top_f :: rest_f &
     (pin_t == [] | 
      fresh top_t, rest_t in
        pin_t == top_t :: rest_t & Std.Nat.lto top_f top_t Std.Bool.truo
     ) &
     pin_f_res == rest_f &
     pin_t_res == top_f :: pin_t &
     eval_pins' a'' b'' c'' moves' a' b' c'
)
   
let rec eval_pins a b c moves a' b' c' = 
  conde [
    ?& [moves === nil (); a === a'; b === b'; c === c';];
    fresh (f t moves' pin_f pin_t pin_f_res pin_t_res a'' b'' c'') (
      ?& [ moves === (pair f t) % moves';
           conde [
             ?& [f === !!A; t === !!B; pin_f === a; pin_f_res === a''; pin_t === b; pin_t_res === b''; c'' === c]; 
             ?& [f === !!A; t === !!C; pin_f === a; pin_f_res === a''; pin_t === c; pin_t_res === c''; b'' === b]; 
             ?& [f === !!B; t === !!A; pin_f === b; pin_f_res === b''; pin_t === a; pin_t_res === a''; c'' === c]; 
             ?& [f === !!B; t === !!C; pin_f === b; pin_f_res === b''; pin_t === c; pin_t_res === c''; a'' === a]; 
             ?& [f === !!C; t === !!A; pin_f === c; pin_f_res === c''; pin_t === a; pin_t_res === a''; b'' === b]; 
             ?& [f === !!C; t === !!B; pin_f === c; pin_f_res === c''; pin_t === b; pin_t_res === b''; a'' === a]; 

           ];     
           fresh (top_f rest_f) (
             ?& [ 
                  pin_f === top_f % rest_f;
                  conde [ pin_t === nil (); 
                          fresh (top_t rest_t) (
                            ?& [pin_t === top_t % rest_t; 
                                Nat.lto top_f top_t Bool.truo;] )
                        ];
                  pin_f_res === rest_f;
                  pin_t_res === top_f % pin_t;
                  eval_pins a'' b'' c'' moves' a' b' c';
                ]
           )
         ]
    )
  ]
      
let show_pins' c =
  show(List.logic) (show(Pair.logic) (show(logic) (show(pin))) (show(List.logic) (show(Nat.logic)))) c

let lst0123 = (nat 0) % ((nat 1) % ((nat 2) %< (nat 3)))
let lst1234 = (nat 1) % ((nat 2) % ((nat 3) %< (nat 4)))
let lst123  = (nat 1) % ((nat 2) %< (nat 3))
let lst12   = (nat 1) %< (nat 2)
let lst1    = !< (nat 1)
let lst2    = !< (nat 2)
let lste    = nil ()

let reify_pin = Pair.reify reify reify

let show_l_pin = show(logic) (show(pin))
let show_move = show(Pair.logic) show_l_pin show_l_pin
let show_list_of_moves = show(List.logic) show_move

let show_list_of_pins = show(List.logic) (show(Nat.logic))  

let findMoves a b c a' b' c' n =
  Printf.printf "-----------------------------------\n%!";
  let result = 
        run q 
         (fun m -> eval_pins' a b c m a' b' c') 
         (fun c -> c)  
  in
  if n > 0 
  then  
    L.iter (fun c -> Printf.printf "%s\n%!" @@ show_list_of_moves @@ c#reify (List.reify reify_pin) ) 
    @@ Stream.take ~n:n result 
  else 
    if Stream.is_empty result 
    then Printf.printf "No results, as expected"
    else Printf.printf "Something is wrong: non empty result"

let _ = 
  Printf.printf "Here what we get on the pin a':\n%!";
  let result = 
        run q
          (fun a' -> eval_pins lst1 lste lste (ocanren([(A, B)])) (*!< (pair !!A !!C)*) lste a' lst1)
          (fun c -> c) 
  in 
  L.iter (fun c -> Printf.printf "%s\n%!" @@ show_list_of_pins @@ c#reify (List.reify Nat.reify)) @@ Stream.take ~n:1 result

let _ = 
  ocanren (findMoves [1; 2; 3] [] [] [] [1; 2; 3] []) 1 (* lst1234 lste lste lste lst1234 lste 1 *);;

