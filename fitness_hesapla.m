function [best_fitness, best_cycle, best_duzgunluk, best_solution]=fitness_hesapla(istasyon, e_cycle, duzgunluk,population)

global best_fitness
global best_duzgunluk
global best_cycle
global best_solution


for i=1:length(istasyon)
    if best_fitness>istasyon(i)
        best_fitness=istasyon(i);
    end
end

for i=1:length(istasyon)
    if (istasyon(i)==best_fitness)&&(best_cycle>e_cycle(i))
       best_cycle=e_cycle(i);
    end
end


for i=1:length(istasyon)
     if (istasyon(i)==best_fitness)&&(best_cycle==e_cycle(i))&&(best_duzgunluk>duzgunluk(i));
         best_duzgunluk=duzgunluk(i);
         best_solution=population(i,:);
     end
end
end