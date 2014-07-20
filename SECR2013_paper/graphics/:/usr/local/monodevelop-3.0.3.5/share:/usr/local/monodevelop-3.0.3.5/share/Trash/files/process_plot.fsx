let data file = 
    System.IO.File.ReadAllLines(file) 
    |> Seq.map (fun s -> s.Split ' ') 
    |> Seq.map (fun a -> a|>Array.filter (fun x -> x.Length <> 0)|> (fun a -> a.[0].Trim() |> int , a.[1].Trim().Replace(',','.') |> float)) 
    |> Array.ofSeq |> Array.sortBy fst

let f x y =
    Array.map2 (fun (a,b) (x,y) -> a,(b / y)) x y 

let l1 = data "test_out1.plot"
let l2 = data "test_out2.plot"
let l5 = data "test_out5.plot"
let l10 = data "test_out10.plot"

printfn  "%A" l10
//printfn  "%A" (f l10 l5)

(*f l10 l5
|> Array.map (fun (x,y) -> string x + " " + string y)
|> fun lines -> System.IO.File.WriteAllLines("l_10_5.plot", lines)
*)
