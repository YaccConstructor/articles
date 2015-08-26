for %%i in (0_tok, 20_int, 20_tok, 24_int, 24_inv, 24_tok, 35_inv, 35_tok, 49_inv, calc_ex, calc_ex_compose, calc_ex_det, calc_ex_fst, calc_ex_res, ident_ex, n_ex, token, tokenEx, while_appr, WhileEx) do (
    dot %%i.dot -o ..\%%i.pdf -Tpdf
)
