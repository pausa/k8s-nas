KC=microk8s.kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=--all-containers -f

deploy: service secret deployment
	@echo "done"

undeploy: clean-deployment
	@echo "done"

clean: clean-deployment clean-service clean-secret
	@echo "done"

dockerfile:
	cd docker && ./docker.sh

%:
	$(KC) apply -f $*.yaml 

clean-%:
	$(KC) delete -f $*.yaml 2>/dev/null || echo "nothing to do"

logs:
	$(KC) logs deployment/$(DEPLOYMENT) $(LOGFLAGS)

logs-wordpress:
	$(KC) logs deployment/$(DEPLOYMENT) -c wordpress -f

logs-mysql:
	$(KC) logs deployment/$(DEPLOYMENT) -c wordpress-mysql -f

list:
	$(KC) get pods -l app=$(DEPLOYMENT) -w

exec:
	$(KC) exec -it deployment/$(DEPLOYMENT) -c wordpress-mysql -- bash


