open MiniKanrenStd
open MiniKanren
open GT

module Simple =
  struct
   
    @type ('a, 'b) fa =
    | Conj of 'a * 'a
    | Disj of 'a * 'a
    | Var  of 'b with show, gmap

    @type f = (f, string logic) fa logic with show, gmap

    module F = Fmap2 (struct type ('a, 'b) t = ('a, 'b) fa let fmap f g x = gmap(fa) f g x end)

    let rec reify_f f = F.reify reify_f reify f
                  
    let conj x y = inj @@ F.distrib (Conj (x, y))
    let disj x y = inj @@ F.distrib (Disj (x, y))
    let var  x   = inj @@ F.distrib (Var x)

    let rec evalo st fm =
      fresh (x y v) (
        conde [
          fm === conj x y &&& evalo st x &&& evalo st y;
          fm === disj x y &&& (evalo st x ||| evalo st y);
          fm === var  v   &&& List.membero st v
      ])

    let _ =
      Printf.printf "%d\n" @@
      List.length @@ Stream.take @@
      run qrs
        (fun q r s -> (List.lengtho s (nat 2)) &&& (r =/= q) &&& evalo s (disj (var r) (var q)))
        (fun q r s -> s);
  
      List.iter (fun s -> Printf.printf "%s\n" @@ show(f) (s#reify reify_f)) @@ Stream.take ~n:10 @@
      run qrs
        (fun q r s -> (r =/= q) &&& evalo (r %< q) s)
        (fun _ _ s -> s)
      
  end
    
module Elaborated =
  struct
   
    @type ('a, 'b) fa =
    | Conj of 'a * 'a
    | Disj of 'a * 'a
    | Neg  of 'a
    | Var  of 'b with show, gmap

    @type f = (f, string logic) fa logic with show, gmap

    module F = Fmap2 (struct type ('a, 'b) t = ('a, 'b) fa let fmap f g x = gmap(fa) f g x end)

    let rec reify_f f = F.reify reify_f reify f
                  
    let conj x y = inj @@ F.distrib (Conj (x, y))
    let disj x y = inj @@ F.distrib (Disj (x, y))
    let var  x   = inj @@ F.distrib (Var x)
    let neg  x   = inj @@ F.distrib (Neg x)

    let rec eval st = function
    | Conj (l, r) -> eval st l && eval st r
    | Disj (l, r) -> eval st l || eval st r
    | Neg   e     -> not (eval st e)
    | Var   x     -> List.assoc x st
                   
    let _ = Printf.printf "%s\n%!" (string_of_bool @@ eval [("x", true)] (Conj (Neg (Var "x"), (Var "x"))))           
                       
    let empty = []
    
    let extend v n b = (n, b) :: v
 
    let rec solve env b = function
    | Var n -> ( match List.assoc_opt n env with 
                 | None -> [extend env n b]
                 | Some b' -> if b == b' then [env] else [] )
    | Neg e -> solve env (not b) e
    | Conj (l, r) -> if b 
                     then let envs = solve env b l 
                          in  List.concat (List.map (fun env -> solve env b r) envs)
                     else solve env b l @ solve env b r
    | Disj (l, r) -> solve env b (Neg (Conj (Neg l, Neg r))) 
                   
    let check f = List.map (fun env -> eval env f ) (solve empty true f)               
    
    let s f = solve empty true f 
    
    let f1 = Disj (Neg (Var "x"), (Var "x"))
    let f2 = Conj (Neg (Var "x"), (Var "x"))
    
    let show_env = show(list) (show(pair) id string_of_bool)
    
    let _ = Printf.printf "%s\n%!" @@ show(list) show_env @@ s f1
                 
    let check f = List.for_all (fun env -> eval env f) (s f)
                   
    let _ = Printf.printf "%s\n%!" @@ string_of_bool @@ check f1
    let _ = Printf.printf "%s\n%!" @@ string_of_bool @@ check f2

    (* let check f = and [let r = eval v f in r == Nothing || r == Just True  | v <- solve f]               *)
                   
    let rec evalo st fm u =
      fresh (x y z v w) (
        conde [
          ?& [fm === conj x y; evalo st x v; evalo st y w; Bool.ando v w u];
          ?& [fm === disj x y; evalo st x v; evalo st y w; Bool.oro  v w u];
          ?& [fm === neg  x  ; evalo st x v; Bool.noto v u];
          ?& [fm === var  z  ; List.assoco z st u];
        ])

    let _ =
      Printf.printf "*********************************\n";
      List.iter (fun s ->
          Printf.printf "%s\n" @@ show(List.logic)
                                    (show(Pair.logic)
                                       (show(logic) (show(string)))
                                       (show(logic) (show(bool)))
                                    )
                                  
                                    (s#reify (List.reify (Pair.reify reify reify)))) @@ Stream.take ~n:10 @@
      run q
        (fun st -> evalo st (conj (neg @@ var !!"x") (var !!"y")) !!true)
        (fun st -> st)
  
  end
    
    
         

                                                  
