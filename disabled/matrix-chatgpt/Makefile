KC=microk8s.kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=--all-containers -f

deploy: secret deployment
	@echo "done"

undeploy: clean-deployment
	@echo "done"

clean: clean-deployment clean-service
	@echo "done"

secret:
	$(KC) delete secret $(DEPLOYMENT) || exit 0
	$(KC) create secret generic $(DEPLOYMENT) --from-env-file=$(HOME)/.config/$(DEPLOYMENT)/.env

%:
	$(KC) apply -f $*.yaml 

clean-%:
	$(KC) delete -f $*.yaml 2>/dev/null || echo "nothing to do"

logs:
	$(KC) wait --for condition=Ready pod -l app=$(DEPLOYMENT) --timeout=-1s && \
	$(KC) logs deployment/$(DEPLOYMENT) $(LOGFLAGS)

list:
	$(KC) get pods -l app=$(DEPLOYMENT) -w

exec:
	$(KC) exec -it deployment/$(DEPLOYMENT) -- sh

