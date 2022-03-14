clc;
clear all;
close all;

% given sample (priorities)
op=  [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        2 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
        2 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
        3 2 1 0 0 0 0 0 0 0 0 0 0 0 0;
        4 3 2 1 0 0 0 0 0 0 0 0 0 0 0;
        5 3 2 1 0 0 0 0 0 0 0 0 0 0 0;
        6 4 3 2 1 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        9 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        10 9 0 0 0 0 0 0 0 0 0 0 0 0 0;
        10 9 0 0 0 0 0 0 0 0 0 0 0 0 0;
        11 10 9 0 0 0 0 0 0 0 0 0 0 0 0;
        12 11 10 9 0 0 0 0 0 0 0 0 0 0 0;
        13 11 10 9 0 0 0 0 0 0 0 0 0 0 0];

    % times for each job
    time=[11 17 9 5 8 12 10 3 11 17 9 5 8 12 10];
    
    [satir,sutun]=size(op);
    
    maxIter=input('Lutfen maksimum iterasyon sayisini giriniz:');
    pop_size=input('Lütfen populasyon buyuklugunu giriniz:');
    if pop_size>500 || maxIter>100000
        return
    end
    
    population=[];
    spop=0;
    cycle=25; 
    
   
   
    global best_fitness
    global best_duzgunluk
    global best_cycle
    global best_solution
    
    best_fitness=100;
    best_duzgunluk=100;
    best_cycle=cycle;
    best_solution=[];
    
    caprazIhtimal =0.9;
    mutasyonIhtimal=0.2;
    
    for k=1:pop_size

        op1=op;
        sayac_a=0;
        list=[];
        atanan=[];
        istasyon=[];

       while length(atanan)<satir
       sayac=0;

            for i=1:satir
                    if sum(op1(i,:))==0;
                        indis=i;
                        sayac=sayac+1;
                        list(sayac)=indis;
                    end
            end

            if length(atanan)>0
                list1=duzelt(list,atanan);
                sayac_a=sayac_a+1;
                r=randi(length(list1));
                atanan(sayac_a)=list1(r);
            else
                list1=list;
                sayac_a=sayac_a+1;
                r=randi(length(list1));
                atanan(sayac_a)=list1(r);
            end


            for a=1:satir
                for b=1:sutun 
                    if op1(a,b)==atanan(sayac_a)
                        op1(a,b)=0;
                    end
                end
            end

      end
        spop=spop+1;
        population(spop,:)=atanan;
        
    end

[istasyon,duzgunluk,e_cycle]=hesapla(population,time,cycle);
[best_fitness, best_cycle, best_duzgunluk, best_solution]=fitness_hesapla(istasyon, e_cycle, duzgunluk,population);

iterasyon=0;
while iterasyon<maxIter
    
%     if iterasyon<floor(maxIter/3)
    fitness=istasyon;
%     elseif  iterasyon<floor(2*maxIter/3)  
%         fitness=e_cycle;
%     else
%         fitness=duzgunluk;
%     end
    
    fitness=100./fitness;
    toplam=sum(fitness);
    n_fitness=fitness/toplam;
    kumulatif(1)=n_fitness(1);
    for i=2:pop_size
        kumulatif(i)=kumulatif(i-1)+n_fitness(i);
    end
    
    s=0;
    caprazPopulasyon=[];
while s<pop_size
    
        r=rand();
        for i=1:pop_size
            if kumulatif(i)>=r
                secilen1=i;
                break
            end
        end

        secilen2=secilen1;
        while secilen2==secilen1
            r=rand();
            for i=1:pop_size
                if kumulatif(i)>=r
                    secilen2=i;
                    break
                end
            end
        end


        r1=rand();
        if r1<=caprazIhtimal
            parent1=population(secilen1,:);
            parent2=population(secilen2,:);
            
            point1=randi(satir-1);
            point2=point1;
            
            while abs(point1-point2)<4
            point2=randi(satir-1);
            end
            kucuk=min(point1,point2);
            buyuk=max(point1,point2);

            child1=parent1;
            child2=parent2;

            sayac=kucuk; 
            for i=1:satir
                for j=kucuk+1:buyuk
                    if parent2(i)==parent1(j)
                        sayac=sayac+1;
                        child1(sayac)=parent2(i);
                    end
                end
            end

            sayac=kucuk;
            for i=1:satir
                for j=kucuk+1:buyuk
                    if parent1(i)==parent2(j)
                        sayac=sayac+1;
                        child2(sayac)=parent1(i);
                    end
                end
            end
        s=s+2;
        caprazPopulasyon(s-1,:)=child1;
        caprazPopulasyon(s,:)=child2;
        end
end

  [c_istasyon,c_duzgunluk,c_e_cycle]=hesapla(caprazPopulasyon,time,cycle);
  [best_fitness, best_cycle, best_duzgunluk, best_solution]=fitness_hesapla(c_istasyon, c_e_cycle, c_duzgunluk,caprazPopulasyon);
  
  mutasyonPopulasyon=caprazPopulasyon;
  mutasyonPopulasyon=mutasyon(mutasyonPopulasyon,pop_size,op,mutasyonIhtimal);   
  [m_istasyon,m_duzgunluk,m_e_cycle]=hesapla(mutasyonPopulasyon,time,cycle);
  [best_fitness, best_cycle, best_duzgunluk, best_solution]=fitness_hesapla(m_istasyon, m_e_cycle, m_duzgunluk, mutasyonPopulasyon);
  
    population=mutasyonPopulasyon;
    istasyon=m_istasyon;
    duzgunluk=m_duzgunluk;
    e_cycle=m_e_cycle;
    
    population(1,:)=best_solution;
    istasyon(1)=best_fitness;
    iterasyon=iterasyon+1;
    y(iterasyon)=best_duzgunluk;
    z(iterasyon)=best_cycle;
end

    fprintf('%d.Iteration\n',iterasyon);
    fprintf('En iyi istasyon sayisi: %g\n',best_fitness);
    fprintf('En iyi duzgunluk degeri: %g\n',best_duzgunluk);
    fprintf('En iyi efektif cycle degeri: %g\n',best_cycle);
    fprintf('En iyi siralama:\n');
    for i=1:sutun
        fprintf('%d\t',best_solution(i));
    end
x=1:iterasyon;
subplot(1,2,1);
    plot(x,y,'r-');
    legend('Duzgunluk Indeksi');
    title('Iterasyona bagli olarak duzgunluk indeksindeki degisim');
subplot(1,2,2);
    plot(x,z,'k-');
    legend('Cycle Time')
    title('Iterasyona bagli olarak cycle time degisimi');
