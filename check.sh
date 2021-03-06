#!/usr/bin/env fish

function test_nas -a condition message
	set_color (eval $condition &> /dev/null && echo "green" || echo "red")
	echo "$message"
	set_color normal
end

function test_disk -a dir perc
	return (df -hP $dir | tail -1 | awk '{print int($5)}' | xargs test $perc -gt)
end

function test_date -a dir max_days
	set date_dir (date -r $dir '+%s')
	set date_now (date '+%s')
	set diff_days (math "($date_now - $date_dir) / (60 * 60 * 24)")
	return (test "$diff_days" -lt "$max_days")
end

function test_files -a dir max_files
	return (test (ls -1 $dir | wc -l) -lt "$max_files")
end

function test_job -a job_name expected_status
	set job_status (kubectl get pod | grep $job_name | tail -1 | awk '{print $3}')
	return (test "$job_status" = $expected_status)
end

function test_vpn
	set host_ip (curl -4 ifconfig.co 2> /dev/null)
	set pod_ip (kubectl exec service/rutorrent -- curl -4 ifconfig.co 2> /dev/null)
	echo $host_ip $pod_ip
	return (test "$host_ip" != "$pod_ip")
end

set stow_home /media/usb0/backup/media/backup

echo "Disks:"
test_nas 'mount | grep -q usb0' 'External drive mounted'
test_nas 'test_disk /home/pausa 90' 'More than 10% on main disk'
test_nas 'test_disk /media/usb0/backup 90' 'More than 10% on external disk'
echo
echo "Backup"
test_nas "test_date $stow_home/stow-play 3" 'Personal backup more recent than 3 days'
test_nas "test_files $stow_home/stow-play 5000" 'Personal backup less than 5000 files'
test_nas "test_date $stow_home/stow-antonio 3" 'Work backup more recent than 3 days'
test_nas "test_files $stow_home/stow-antonio 5000" 'Work backup less than 5000 files'
echo
echo "Kubernetes Cluster:"
test_nas "kubectl version" 'Kubernetes online'
test_nas "nc -z localhost 32400" 'Plex online'
test_nas "nc -z localhost 139" 'Samba online'
test_nas "nc -z localhost 8112" 'Torrent online'
test_nas 'test_vpn' 'VPN running for torrent pod'
echo
echo "SMART:"
test_nas "test_job smart-check Completed && test_job smart-test Completed" 'SMART checks running'

echo "Short output:"
kubectl get pod -oname | grep 'smart-check' | tail -1 | xargs kubectl logs | grep --color=never /scanning
echo
kubectl get pod -oname | grep 'smart-check' | tail -1 | xargs kubectl logs | grep Extended | head -10


