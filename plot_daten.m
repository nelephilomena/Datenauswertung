function plot_daten(N,fig_num,col1,col2,rmax,varargin)

% Die Funktion plottet die Trajektorien fuer das jeweilige Datenset. Dieses
% kann die zeitliche und raeumliche Verteilung eines einzelne getesteten
% Fisches (N = 1) oder einer Fischgruppe (N = 4) sein. Jeder Versuch einer
% Versuchsreihe wird in einem subplot dargestellt.
%
% Syntax: 
%        plot_daten(N,fig_num,col1,col2,rmax,varargin)
%
% Parameter: 
%             N           Anzahl der Fische im Datensatz
%             fig_num     Nummmer des zu öffenenden Fensters
%             col1        Hexacode der Farbe hellblau
%             col2        Hexacode der Farbe dunkelblau
%             rmax        Radius der Kreises von dem Plot
%             varargin{1} N = 1 phi_vec
%                         N = 4 Nummern
%             varargin{2} N = 1 r_vec
%                         N = 4 leader
%             varargin{3} N = 1 plot_ind_vec
%                         N = 4 filenames
%             varargin{4} N = i psi (bevorzugte Richtung)
%                         N = 4 L 
%
% Nele Schuff, 19-11-2023

if N == 1
    phi_vec = varargin{1};
    r_vec =  varargin{2};
    ind_plot_vec =  varargin{3};
    psi = varargin{4};

    % Plot der Trajektorien von allen Beobachtungen eines Fisches
    for i_plot = 1 : numel(ind_plot_vec)
        figure(fig_num)
        ind_plot = ind_plot_vec(i_plot);
        subplot(2,3,i_plot)
        polarplot(phi_vec(:,ind_plot),r_vec(:,ind_plot),...
            'Color',col1,'LineStyle','-','Marker','.','MarkerSize',10)
        hold on
        phi_vec(isnan(phi_vec)) = 0;

        % Pfeil hinzufuegen der durchschnittlichen Richtung 
        polarplot([0,circ_mean(phi_vec(:,ind_plot))],...
            [0,circ_r(phi_vec(:,ind_plot))*max(max(r_vec))],...
            'Color',col2,'LineStyle','-','LineWidth',2,'MarkerSize',1)
        hold on
        polarplot(circ_ang2rad(psi),max(max(r_vec)),...
            'r*','LineWidth',2,'MarkerSize',10)
        hold off

        % Beschriftung der Achsen
        ax = gca;
        ax.ThetaDir = 'counterclockwise';
        ax.ThetaTick = [0 45 90 135 180 225 270 315];
        ax.ThetaTickLabel = {'270°','315°','0°','45°','90°','135°','180°','225°'};
        ax.RLim = ([0 rmax]);
        ax.RAxisLocation = 180;
        ax.RAxisLocationMode = 'manual';

        % Hinzufuegen eines Titels
        title([num2str(i_plot),'. Versuch']);
        if i_plot == 5
            legend('Trajektorie','Durchschnittliche Richtung',...
                'Bevorzugte Richtung','LineWidth',0.2,...
                'Location','southeastoutside','FontSize',10);
        end
    end

elseif N == 4
    Nummern = varargin{1};
    leader = varargin {2};
    filenames = varargin{3};
    L = varargin{4}; 

    [~,T_Dodos_mean] = read_tab_single_phi();

    % Fuer die gegebeenen Nummern werden die Daten der 4-er Gruppen eingelesen
    for i = 1 : numel(Nummern)
        i_nummer = Nummern(i);
        file_name = filenames(i_nummer).name;

        % Einlesen der Datein. Aus den Daten werden nach Transformation die x-
        % und y-Werte bestimmt, sowie der Radius, der Winkel phi der
        % Position.
        [~,~,r_vec,phi_vec,~,~,~] = ...
            read_tab_group(file_name);

        % Speichern der Parametern der Matrix fuer jede Datei. Der
        % Ordnungsparameter ist schon der Durchschnitt ueber die Zeit t. 
        % Fuer den Winkel phi wird der Durchschnitt ueber die Zeit t bestimmt 
        % und ebenfalls in einem dafuer vorgesehenen Vektor abgespeichert.
        phi_mean = circ_mean(reshape(phi_vec,numel(phi_vec),1));
        r_strich = circ_r(reshape(phi_vec,numel(phi_vec),1));

        % Plot der Trajektorien aller Fische der Fischgruppe 
        figure(fig_num)
        if numel(Nummern) == 4
            subplot(2,2,i)
        else
            subplot(1,3,i)
        end
        polarplot(phi_vec(1,:),r_vec(1,:),...
            'Color',col1,'LineStyle','-','Marker','.','MarkerSize',10)
        hold on
        polarplot(phi_vec(2,:),r_vec(2,:),...
            'Color',col1,'LineStyle','-','Marker','.','MarkerSize',10)
        hold on
        polarplot(phi_vec(3,:),r_vec(3,:),...
            'Color',col1,'LineStyle','-','Marker','.','MarkerSize',10)
        hold on
        polarplot(phi_vec(4,:),r_vec(4,:),...
            'Color',col1,'LineStyle','-','Marker','.','MarkerSize',10)
        hold on
        polarplot(0:0.01:2*pi,L,'k-')
        hold on

        % Pfeil hinzufuegen der durchschnittlichen Richtung 
        polarplot([0,phi_mean],[0,r_strich*max(max(r_vec))],...
            'Color',col2,'LineWidth',2,'MarkerSize',1)
        hold off

        % Beschriftung der Achsen
        ax = gca;
        ax.RTick = [];
        ax.ThetaTick = [0,45,90,135,180,225,270,315];
        ax.ThetaTickLabel = {'270 °';'315 °';'0 °';'45 °';'90 °';'135 °';'180 °';'225 °'};

        % Wenn ein leader-Fisch vorhanden ist, wird ein Stern hinzugefuegt,
        % welcher die bevorzugte Richtung des Fisches (also der
        % durchschnittliche Winkel phi aus den Einzelversuchen darstellt)
        if ~isnan(leader)
            hold on
            polarplot(circ_ang2rad(T_Dodos_mean{leader,3}),max(max(r_vec)),...
                'r*','LineWidth',2,'MarkerSize',10)
            hold off
        end
        title([num2str(i,'%.0f'),'. Versuch ']);
        ax= gca;
        ax.FontSize = 11; 
    end
end