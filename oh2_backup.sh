#/bin/sh
echo 'openHAB Backup-Skript (by frombeyond.de - V1 - 170802)'
# openHAB Service stoppen
echo 'Stoppe openHAB-Service'
sudo systemctl stop openhab2.service
# Homegear Service stoppen
echo 'Stoppe Homegear-Service'
sudo systemctl stop homegear.service

# Backup-Verzeichnis erstellen
BACKUPDIR="~/backup/openhab-backup"
HGDIR="/etc/homegear"
mkdir -p $BACKUPDIR

# Sichern der openHAB Konfiguration
echo 'Erstelle openHAB Backup'
cp -arv /etc/openhab2 "$BACKUPDIR/openhab_conf"
cp -arv /var/lib/openhab2 "$BACKUPDIR/openhab_userdata"
rm -rf "$BACKUPDIR/userdata/cache"
rm -rf "$BACKUPDIR/userdata/tmp"

# Sichern der HomeGear Konfiguration (falls vorhanden)
if [ -d "HGDIR" ]; then
echo 'Homegear gefunden - Erstelle Backup'
cp -arv /etc/homegear "$BACKUPDIR/homegear_conf"
cp -arv /var/lib/homegear "$BACKUPDIR/homegear_userdata"
fi

# Services wieder starten
echo 'Starte Services wieder'
sudo systemctl start homegear.service
sudo systemctl start openhab2.service
echo 'Backup-Skript abgeschlossen'