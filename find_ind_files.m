function ind_plot_vec = find_ind_single(filenames,fischnummer)

% Die Funktion bestimmt die Indexe fuer die Dateien fuer die jeweilige
% Fischnummer.
%
% Syntax: 
%         plot_ind_vec = find_ind_fischnummer(filenames,fisch_nummer)
%           
% Parameters:
%            filenames    Name des files
%            fisch_nummer Nummer des Fisches
%
% Nele Schuff, 19-11-2023

fisch_nummer_str = num2str(fischnummer);
ind_plot_vec = [];

for i = 1 : length(filenames)
     names_char = convertStringsToChars(filenames(i).name);
 if length(fisch_nummer_str) == 2
     if names_char([13,14]) == fisch_nummer_str([1,2])
         ind_plot_vec = [ind_plot_vec,i];
     end
 elseif names_char(14) == '.'
     if names_char(13) == fisch_nummer_str(1)
         ind_plot_vec = [ind_plot_vec,i];
     end
 end
 
end
end 
