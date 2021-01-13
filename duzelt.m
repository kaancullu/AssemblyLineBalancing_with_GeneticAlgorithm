function list1=duzelt(list,atanan)


for i=1:length(list)
    for j=1:length(atanan)
        if list(i)==atanan(j)
            list(i)=0;
        end
    end
end

list1=[];
sayac=0;
for i=1:length(list)
    if list(i)~=0
        sayac=sayac+1;
        list1(sayac)=list(i);
    end
end
end

