KC=kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=--all-containers -f
BRIDGES=$(wildcard ../synapse-*)

deploy: service deployment
	@echo "done"

undeploy: clean-deployment
	@echo "done"

clean: clean-deployment clean-service
	@echo "done"

docker-run:
	cd docker && ./docker.sh

%:
	$(KC) apply -f $*.yaml 

clean-%:
	$(KC) delete -f $*.yaml 2>/dev/null || echo "nothing to do"

logs:
	$(KC) logs deployment/$(DEPLOYMENT) $(LOGFLAGS)

list:
	$(KC) get pods -l app=$(DEPLOYMENT)

exec:
	$(KC) exec -it deployment/$(DEPLOYMENT) -- sh

verify:
	openssl s_client localhost:853 | grep -i "verification"
