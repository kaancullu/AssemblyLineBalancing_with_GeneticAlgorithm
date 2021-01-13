function yeni=yer_degistirme(operasyon,ata,eski,ras);
      sutun=length(eski);
      eski(ras)=[];
       
       if ata==1
           part1=eski;
           yeni=[operasyon part1];
       elseif ata==sutun
           part1=eski;
           yeni=[part1 operasyon];
       else
       uzunluk=length(eski);
       part1=eski(1:ata-1);
       part2=eski((ata):uzunluk);
       yeni=[part1 operasyon part2];
       end
