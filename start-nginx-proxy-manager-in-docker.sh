# Start Nginx Proxy Manager in Docker after reboot.
#
# start the nginxpm_db_1
echo "starting nginxpm_db_1 in Docker"
docker start nginxpm_db_1
# start the nginxpm_app_1
echo "starting nginxpm_app_a in Docker"
docker start nginxpm_app_1
# show docker apps status
echo "Getting Docker Apps status"
docker ps -a