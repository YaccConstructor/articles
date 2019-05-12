for /r %%v in (*.dia) do dia -e %%v.png -t png -s 1280x %%v
for /r %%v in (*.dia.png) do move /y %%v pictures