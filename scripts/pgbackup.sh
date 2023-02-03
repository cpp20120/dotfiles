!/bin/sh
# sql_to_csv.sh

BACKUP_HOME='/opt/backup'


if [ $# -ne 0 ]
then
    LOGS_END_DATE=$1
else
    LOGS_END_DATE=`date --date="yesterday -90 days" "+%Y-%m-%d"`
fi

_export_csv_file=$BACKUP_HOME/data/audit_logs_until_$LOGS_END_DATE.csv

echo ''
echo `date`' :: APP AUDIT logs back up to csv started.....'
echo '#############################################################'

echo 'End Date is '$LOGS_END_DATE

CONN="/usr/bin/psql -w -U postgres -h localhost -d database_name"

echo ''
echo `date`" :: Export Query ...."
QUERY_CSV="SELECT * FROM aac_cloud_schema.audit_log WHERE request_timestamp < '$LOGS_END_DATE'"
echo "$QUERY_CSV"

echo ''
echo `date`" :: File Export Started.."
echo "File : ${_export_csv_file}"

echo "copy ($QUERY_CSV) to '$_export_csv_file' with (FORMAT CSV, HEADER)" | $CONN 

echo ''
echo `date`" :: File Export completed."
echo '#############################################################'

echo ''
if [ $? -eq 0 ];then
  echo `date`" :: Deleting Older Data.."
  $CONN -c "DELETE FROM aac_cloud_schema.audit_log WHERE request_timestamp < '$LOGS_END_DATE'"
  echo `date`" :: Export Completed"
else
  echo `date`" :: Export Failed"
fi

echo '#############################################################'
