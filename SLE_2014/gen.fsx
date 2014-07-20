let m = 10
let n = 250

let gen n m = 
 let tail f t = 
    let gen  i = 
       sprintf "%i -> %i [ label=\" xx%i < 10 or  yy%i > 10 and zz%i <20 or cc%i > 20 \"];\n" f t i i i i
    [for i in 1..m -> gen i]
 let block f t =
    let gen i = 
       sprintf "%i -> %i [ label=\" x%i , y%i + z%i, c%i \"];\n" f t i i i i
    [for i in 1..m -> gen i]

 let s = "0 -> 1 [ label=\"select \"];\n"
 let frm f t = sprintf "%i -> %i [ label=\" from y where z > 20 and x < 30 and\"];\n" f t

 let vCount = ref 1

 let g n = 
   [
   yield "digraph g{"
   yield! [for i in [0..n+4] -> sprintf "%i;\n" i]
   yield s
   yield! [for i in [1..n+1] -> block i (i+1)] |> List.concat
   yield frm (n+2) (n+3)
   yield! tail (n+3) (n+4)
   yield "}"
   ]
   |> String.concat ""


 for i in [1..n] do 
   //printfn "m=%i i=%i"m i
   System.IO.File.WriteAllText(sprintf "%i/%i.dot " m  i,(g i))

do for i in [1..m] do gen n i
