%% main_daten
%  Skript zur Datenauswertung
 clear all
%% Daten der einzelnen Fische
%  Einlesen aller Beobachtungen aus der Tabelle mit den Werten fuer die
%  Winkel (phi) für jeden einzelnen getesteten Fisch
%  (keine Informationen ueber x- und y-Werte)
[T_Dodos_alle,T_Dodos_mean] = read_tab_single_phi();

% Einlesen der der Daten mit den x- und y-Werte aller Fische der
% Einzelpositionen
[x_vec,y_vec,r_vec,phi_vec,v_vec,theta_vec,filenames] = read_tab_single_xy();

% Bestimmen der Indexe von den Fischen mit und ohne Orientierungspraeferenz
[ind_mit,~] = find(T_Dodos_mean{:,8} < 0.05);
[ind_ohne,~] = find(T_Dodos_mean{:,8} >= 0.05);
T_mit = T_Dodos_mean{ind_mit,:};
T_ohne = T_Dodos_mean{ind_ohne,:};

% Farbauswahl
col1 = '#6495ED';
col2 = '#000080';

%% Plot der Verteilung der p-Werte 
%  Dabei wurde der p-Wert von den durschnittlichen Winkel pro Beobachtung
%  gewaehlt 
p_mit = [T_Dodos_mean{:,8}(ind_mit); NaN(numel(T_Dodos_mean{:,8}(ind_ohne)),1)];
p_ohne = [T_Dodos_mean{:,8}(ind_ohne); NaN(numel(T_Dodos_mean{:,8}(ind_mit)),1)];

f1 = figure(1);
h1 = histogram(p_mit,'BinWidth',0.05,'Normalization','probability');
hold on 
h2 = histogram(p_ohne,'BinWidth',0.05,'Normalization','probability'); 
set(h1,'FaceColor',col2,'EdgeColor',col2); 
set(h2,'FaceColor',col1,'EdgeColor',col2);
xlabel('{\it p}','FontSize',12); ylabel('Anteil Fische','FontSize',12)
ylim([0 0.2]); xlim([0 1])
ax = gca; 
ax.FontSize = 18; 
legend('Fische mit Orientierungspräferenz','Fische ohne Orientierungspräferenz',...
    'FontSize',13,'Location','northeast'); 

% Speichern der Abbildung
saveas(gcf,'p_D_E','svg')
%% Plot der Verteilung des Ordnungsparameters ( = Resultatlaenge) 
% Plot von der Verteilung der Resultatlaenge ueber die durschnittlichen 
% Winkel phi pro Beobachtung von jedem einzelnen Fisch

f2 = figure(2);
% Fisch mit Orientierungspraeferenz
subplot(2,1,1)
histogram(T_mit(:,4),'BinWidth',0.05,'Normalization','probability',...
    'FaceColor',col1,'EdgeColor',col2);
ylabel('Anteil Fische','FontSize',20)
xlabel('$\overline{R}_{\phi}$', 'Interpreter', 'latex','FontSize',20)
ylim([0 0.4]); xlim([0 1])
ax = gca; 
ax.FontSize = 15;

% Fisch ohne Orientierungspraeferenz
subplot(2,1,2)
histogram(T_ohne(:,4),'BinWidth',0.05,'Normalization','probability',...
  'FaceColor',col1,'EdgeColor',col2);
ylabel('Anteil Fische','FontSize',17)
xlabel('$\overline{R}_{\phi}$', 'Interpreter', 'latex','FontSize',17)
ylim([0 0.4]); xlim([0 1])
ax = gca; 
ax.FontSize = 15;

% Speichern der Abbildung
saveas(gcf,'Histo_p_D_E','svg')
%% Histogramm der Verteilung von dem durchschnittlichen Winkel der Position
% Die durchschnittlichen Werte der Winkel phi ueber alle Beoabchtungen
% und somit fuer jeden einzelnen Fisch 
% -> Durchschnitt  der Beobachtungen von den Durchschnitten der Winkel phi
% ueber die Zeit

rmax = 0.2;
nbins = 16;

% Plot des Kreis-Histodiagramms für die durchschnittlichen Winkel phi
f3 = figure(3);
polarhistogram(T_Dodos_mean{:,3},nbins,'FaceColor',col1,'FaceAlpha',.8,'EdgeColor',...
    col2,'Normalization','probability') 
hold on 
polarplot([0,circ_mean(T_Dodos_mean{:,3})],[0,circ_r(T_Dodos_mean{:,3})],'Color',col2,'LineWidth',1)
hold off

% Beschriftung der Achsen
ax = gca;
ax.ThetaDir = 'counterclockwise';
ax.ThetaTick = [0 45 90 135 180 225 270 315];
ax.ThetaTickLabel = {'270°','315°','0°','45°','90°','135°','180°','225°'};
ax.RLim = ([0 rmax]);
ax.RAxisLocation = 180;
ax.RAxisLocationMode = 'manual';
ax.FontSize = 20;
f3.Position= [360,100,560,420];

% Speichern der Abbildung
saveas(gcf,'Phi_D_E','svg')
%% Plot der Trajektorien von allen Beobachtungen eines Fisches
% Bestimmung in welcher Datei die Daten des Fisches mit der jeweiligen
% Fischnummer liegen. Dafür muss der Name der Datei in character array
% veraendert werden und die Zahl auch als Character array. Dann wird die
% Zahl in dem Dateinamen mit der Fischnummer verglichen und wenn sie gleich
% wird, wird die Position der Datei abgespeichert in ind_plot

rmax = max(max(r_vec)); 
N = 1;

% Fisch 11 ohne Orientierungspraefernz
fig_num = 4;
fischnummer = 11; 
ind_plot_vec = find_ind_files(filenames,fischnummer);
plot_daten(N,fig_num,col1,col2,rmax,phi_vec,r_vec,ind_plot_vec,T_Dodos_mean{fischnummer,3})

% Speichern der Abbildung
saveas(gcf,'Trajekt_11_E','svg')

% Fisch mit Orientierungspraefernz
fischnummer = 13; 
ind_plot_vec = find_ind_files(filenames,fischnummer);
fig_num = 5;  
plot_daten(N,fig_num,col1,col2,rmax,phi_vec,r_vec,ind_plot_vec,T_Dodos_mean{fischnummer,3})

% Speichern der Abbildung
saveas(gcf,'Trajekt_13_E','svg')
% -> Berechnung der x- und y-Koordinaten in Winkel phi stimmt nicht mit
% der Tabelle der phi-Winkel ueberein

%% Daten der 4-er Gruppenn
% Einlesen aller Dateinnamen der 4-er Gruppen der Dodos
cd 'Daten'\Fischgruppen\
filenames = dir('*4.D.*.csv');
cd ../..

% Bestimmen der Indexe von den Gruppen mit einem informierten Fisch und dem
% Index fuer den jeweiligen informierten Fisch

nummern_gruppen_mit = [1,2,3,11,14,15];
 [ind_gruppe_mit_leader,ind_gruppe_mit,ind_gruppe_ohne] = ...
    find_ind_group(filenames,nummern_gruppen_mit);

%% Plots von den Trajektorien der Fischgruppen mit leader
rmax = 0.5;
L = 14.5; 
N = 4;

ind_gruppe = ind_gruppe_mit_leader(5,1):ind_gruppe_mit_leader(5,2);
ind_leader = ind_gruppe_mit_leader(5,3); 
fig_num = 6; 
plot_daten(N,fig_num,col1,col2,rmax,ind_gruppe,ind_leader,filenames,L)

% Speichern der Abbildung
saveas(gcf,'Trajekt_4','svg')

ind_gruppe = ind_gruppe_mit_leader(2,1):ind_gruppe_mit_leader(2,2);
ind_leader = ind_gruppe_mit_leader(2,3); 
fig_num = 7; 
plot_daten(N,fig_num,col1,col2,rmax,ind_gruppe,ind_leader,filenames,L)

% Speichern der Abbildung
saveas(gcf,'Trajekt_4','svg')
%% Verteilung der durchschnittlichen Winkel phi
%  Fuer jede Fischgruppe wird der Durchschnitt und der Ordnungsparameter r_strich
%  von allen Winkel phi von jedem Fisch fuer jeden Zeitpunkt bestimmt 
phi_mean = NaN(length(filenames),1);
r_strich = NaN(length(filenames),1);

for i = 1: length(filenames)
    file_name = filenames(i).name;
    [x_vec,y_vec,r_vec,phi_vec,time_sim,zeitdauer,kompass_phi] = ...
        read_tab_group(file_name);
    phi_mean(i) = circ_mean(reshape(phi_vec,numel(phi_vec),1));
    r_strich(i) = circ_r(reshape(phi_vec,numel(phi_vec),1));
end

nbins = 16;
rmax = 0.2;

% Plot des Kreis-Histodiagramms der durchschittlichen Winkel phi von den
% Fischgruppen
figure(8)
polarhistogram(phi_mean,nbins,'FaceColor',col1,'FaceAlpha',.8,'EdgeColor',...
    'blue','Normalization','probability') 
hold on 
polarplot([0,circ_mean(phi_mean)],[0,circ_r(phi_mean)],'Color',col2,'LineWidth',3,'MarkerSize',2)
hold off

% Beschriftung der Achsen
ax = gca;
ax.ThetaDir = 'counterclockwise';
ax.ThetaTick = [0 45 90 135 180 225 270 315];
ax.ThetaTickLabel = {'270°','315°','0°','45°','90°','135°','180°','225°'};
ax.RLim = ([0 rmax]);
ax.RAxisLocation = 180;
ax.RAxisLocationMode = 'manual';
ax.FontSize = 20; 
% Von allen Positionswinkeln von allen Fischmitglieder von jedem Zeitpunkt

% Speichern der Abbildung
saveas(gcf,'Phi_D_4','svg')
%% Verteilung der Ordnungsparameters (= Resultantlaenge)
% Vergleich Fischgruppe mit "orientierten" Fisch und Fischgruppe ohne
% "informierten" Fisch

figure(9)
% Fischgruppe mit einem "orientierten" Fisch
subplot(2,1,1)
histogram(r_strich(find(ind_gruppe_mit)),'BinWidth',0.1,'Normalization','probability',...
    'FaceColor',"#99BADD",'EdgeColor','b');
ylabel('Anteil Fischgruppen','FontSize',13)
xlabel('$\overline{R}_{\phi}$', 'Interpreter', 'latex','FontSize',13)
ylim([0 0.4])
xlim([0 1])
ax = gca; 
ax.FontSize = 13;

% Fisch ohne enem "orientierten" Fisch
subplot(2,1,2)
histogram(r_strich(find(ind_gruppe_ohne)),'BinWidth',0.1,'Normalization','probability',...
    'FaceColor',"#99BADD",'EdgeColor','b');
ylabel('Anteil Fischgruppen','FontSize',13)
xlabel('$\overline{R}_{\phi}$', 'Interpreter', 'latex','FontSize',13)
ylim([0 0.4])
xlim([0 1])
ax = gca; 
ax.FontSize = 13;

% Speichern der Abbildung
saveas(gcf,'Phi_Ord_D_4','svg')