function m_pop=mutasyon(m_pop,pop_size,op,mutasyonIhtimal)

[satir,sutun]=size(op);
            
   for i=1:pop_size
       
        onceki=[];
        onceki_sayac=0;
        sonraki=[];
        sonraki_sayac=0;
        r2=rand();
        
        if r2<=mutasyonIhtimal
            ras=randi(sutun);
            operasyon=m_pop(i,ras);
            kontrol=op(operasyon,:);
            
            for j=1:sutun
                if kontrol(j)~=0
                    onceki_sayac=onceki_sayac+1;
                    onceki(onceki_sayac)=kontrol(j);
                end
            end
            
            for m=1:satir
                for n=1:sutun
                    if op(m,n)==operasyon
                        sonraki_sayac=sonraki_sayac+1;
                        sonraki(sonraki_sayac)=m;
                    end
                end
            end
            
            altsinir= 1;
            ustsinir=sutun;
            kontrol=m_pop(i,:); 

            
            if length(sonraki)==0
                
            altsinir=alt_bul(kontrol,onceki,altsinir,sutun);
            if ustsinir-altsinir>2
                ata=ras;
                while ata==ras
                    ata=randi([altsinir+1,ustsinir]);
                end
                
               gecici=m_pop(i,:);
               gecici=yer_degistirme(operasyon,ata,gecici,ras);
               m_pop(i,:)=gecici;
                else
                    continue
                end
                
            elseif length(onceki)==0
            
            ustsinir=ust_bul(kontrol,sonraki,ustsinir,sutun);
                if ustsinir-altsinir>2
                ata=ras;
                while ata==ras
                    ata=randi([altsinir,ustsinir-1]);
                end
                
               gecici=m_pop(i,:);
               gecici=yer_degistirme(operasyon,ata,gecici,ras);
               m_pop(i,:)=gecici;
                else
                    continue
                end
                
                
            else         
                
                altsinir=alt_bul(kontrol,onceki,altsinir,sutun);
                ustsinir=ust_bul(kontrol,sonraki,ustsinir,sutun);
           

                if ustsinir-altsinir>2
                ata=ras;
                while ata==ras
                    ata=randi([altsinir+1,ustsinir-1]);
                end
                
               gecici=m_pop(i,:);
               gecici=yer_degistirme(operasyon,ata,gecici,ras);
               m_pop(i,:)=gecici;
                else
                    continue
                end
                
            end

        end

   end
    
