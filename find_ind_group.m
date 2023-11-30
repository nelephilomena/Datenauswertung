function [ind_gruppe_mit_leader,ind_gruppe_mit,ind_gruppe_ohne] = ...
          find_ind_group(filenames, nummer_gruppe_mit)

% Die Funktion bestimmt die Indexe der Dateinamen, wo eine Fischgruppe mit
% einem leader und ohne einem leader vorhanden ist. 
%
% Syntax: 
%         [ind_gruppe_mit_leader,ind_gruppe_mit,ind_gruppe_ohne] = ...
%          find_ind_group(filenames, nummer_gruppe_mit)
%
% Parameters: 
%             filenames             Name des files
%             nummer_gruppe_mit     Nummern mitden Gruppen, wo ein keader
%                                   vorhanden ist
%
%             ind_gruppe_mit_leader Startindex und Endindex der Dateien der
%                                   jeweiligen Fischgruppe sowie der
%                                   jeweiligen Nummer des leaders
%             ind_gruppe_mit        Indexe der Datein von allen Gruppen mit
%                                   leader
%             ind_gruppe_ohne       Indexe der Datein von allen Gruppen
%                                   ohne leader
%
%
% Nele Schuff, 19-11-2023

ind_gruppe_mit_leader = NaN(length(nummer_gruppe_mit),3);
ind_alle = zeros(29,1);

for g_i = 1: length(nummer_gruppe_mit)
    gruppennummer_str = num2str(nummer_gruppe_mit(g_i));
    ind_sammeln = [];
    % Bestimmen welchen Index die Datei mit der Gruppennummer hat
    for f_i = 1 : 29
        names_char = convertStringsToChars(filenames(f_i).name);
        if length(gruppennummer_str) == 2
            if names_char([6,7]) == gruppennummer_str([1,2])
                ind_sammeln  = [ind_sammeln,f_i];
                ind_alle(f_i) = 1;
            end
        elseif names_char(7) == '.'
            if names_char(6) == gruppennummer_str(1)
                ind_sammeln = [ind_sammeln,f_i];
                ind_alle(f_i) = 1;
            end
        end
    end

    % Abspeichern des ersten Index und des letzten Index
    % In dem Bereich des ersten und letzten Index sind alle Datein für
    % jeden Versuch der Fischgruppe vorhanden
    ind_gruppe_mit_leader(g_i,1) = ind_sammeln(1);
    ind_gruppe_mit_leader(g_i,2) = ind_sammeln(end);

    % Bestimmen der Fischnummer des jeweiligen leaders
    if nummer_gruppe_mit(g_i) == 3
        ind_gruppe_mit_leader(g_i,3) = 3;
    elseif nummer_gruppe_mit(g_i) == 1
        ind_gruppe_mit_leader(g_i,3) = 7;
    elseif nummer_gruppe_mit(g_i) == 2
        ind_gruppe_mit_leader(g_i,3) = 13;
    elseif nummer_gruppe_mit(g_i)  == 11
        ind_gruppe_mit_leader(g_i,3) = 39;
    elseif nummer_gruppe_mit(g_i) == 14
        ind_gruppe_mit_leader(g_i,3) = 41;
    end
end    
% Abspeichern von allen Indexe fuer die Gruppen mit und ohne leader
ind_gruppe_mit = ind_alle;
ind_gruppe_ohne = abs(ind_alle-1); 

end 
