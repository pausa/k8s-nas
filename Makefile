letsencrypt:
	./renew-certificate

list-tls:
	microk8s.kubectl get pod -ocustom-columns="app:metadata.labels.app,volumes:spec.volumes.*.hostPath.path" | grep "/home/pausa/Private"

verify-tls:
	openssl s_client localhost:853 | grep -i "verification"

dates-tls:
	openssl s_client -connect localhost:853 -showcerts -servername madpausa.sytes.net | openssl x509 -noout -dates
