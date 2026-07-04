letsencrypt:
	./renew-certificate

list-tls:
	microk8s.kubectl get pod -ocustom-columns="app:metadata.labels.app,volumes:spec.volumes.*.hostPath.path" | grep "/home/pausa/Private"

verify-tls:
	openssl s_client localhost:853 | grep -i "verification"

dates-tls-sytes-net:
	openssl s_client -connect localhost:8448 -showcerts -servername madpausa.sytes.net | openssl x509 -noout -dates

dates-tls-pausa-dev:
	openssl s_client -connect localhost:443 -showcerts -servername tandoor.pausa.dev | openssl x509 -noout -dates
