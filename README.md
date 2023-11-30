# Datenauswertung

Das Respository Datenauswertung enthält den Datensatz und die Funktionen, um die Daten auszuwerten 
und zu analysieren. Mit den Daten der einzelnen getesten Fische wurde für jeden Fisch über alle 
Beobachtungen ein Rayleigh Test der Positionswinkel durchgeführt, um anhand der Größe des p-Wertes den jeweiligen einzelnen 
Fischen eine Orientierungspräferenz zuzuordnen. 

## Funktionen
CircStat2012a
- circ_ang2rad
- circ_mean
- circ_r
- circ_rad2ang
- circ_rtest
- circ_std

find_ind_files         - 
find_ind_fischnummer   - 
find_ind_group         - 
plot_daten             - Plot der Schwimmbewegung der Fischen über die Zeit
read_tab_group         - Einlesen der Tabellen mit den Positionen (x,y) der Fischgruppen
read_tab_single_phi    - Einlesen der Tabelle mit allen Positionswinkel von allen einzelnen Fischen
read_tab_single_xy     - Einlesen der Tabellen mit den Positionen (x,y) der einzelnen Fischen

## Skript
main_datenauswertung

## Daten
### Dodos
- Dodos_angles_all_Gabi
  -> Tabelle mit den Winkeln in den Spalten pro Beobachtungszeitpunkt 
  -> Für jeden Versuch und für alle einzeln geteste Fische der Art 
- 215 einzelne Tabellen mit den x- und y-Werten der Positionen der Fische 
  für jeden Beobachtungszeitpunkt
  -> Jeweils die ersten x- und y-Werte geben das Zentrum des Beckens an
  -> Nicht vollständig (nicht für jeden Versuch von einem Fisch vorhanden)

### Fischgruppen
- 49 Tabellen mit jeweils den x-und y-Werten der Positionen der Fischgruppe
  -> Es lassen sich nicht die Datenpunkte exakt einem Fisch zuordnen 
     aufgrund der Zeit zwischen den Beobachtungszeitpunkten
  -> Jeweils die ersten x- und y-Werte geben das Zentrum des Beckens an














