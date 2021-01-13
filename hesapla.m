function [istasyon,duzgunluk,e_cycle]=hesapla(population,time,cycle);

        [satir,sutun]=size(population);
        duzgunluk=[];
        e_cycle=[];

        for i=1:satir
            toplam=0;
            d=[];
            sayac=0;
            duzgun=0;
                for j=1:sutun
                    if cycle-toplam>=time(population(i,j))
                        toplam=toplam+time(population(i,j)); 
                        continue
                    else
                        sayac=sayac+1;
                        d(sayac)=toplam;
                        toplam=0;
                        toplam=toplam+time(population(i,j));
                    end
                end
                sayac=sayac+1;
                d(sayac)=toplam;
                for k=1:length(d)
                    duzgun=duzgun+(max(d)-d(k))^2;
                end
            duzgunluk(i)=(sqrt((duzgun))/(length(d)*cycle))*100;
            e_cycle(i)=max(d);
            istasyon(i)=length(d);
        end
end





