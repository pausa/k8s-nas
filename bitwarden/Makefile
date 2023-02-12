KC=microk8s.kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=--all-containers -f

deploy: service secret deployment
	@echo "done"

undeploy: clean-deployment
	@echo "done"

clean: clean-deployment clean-service
	@echo "done"

dockerfile:
	cd docker && ./docker.sh

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

