function ustsinir=ust_bul(kontrol,sonraki,ustsinir,sutun)

            for m=1:sutun
                for n=1:length(sonraki)
                    if (kontrol(m)==sonraki(n))&&(m<ustsinir)   
                        ustsinir=m;
                    end
                end
            end
end