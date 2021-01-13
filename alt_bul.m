function altsinir=alt_bul(kontrol,onceki,altsinir,sutun)
            for m=1:sutun
                for n=1:length(onceki)
                    if (kontrol(m)==onceki(n))&&(m>altsinir)
                       altsinir=m;
                    end
                end
            end                
end