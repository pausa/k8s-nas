KC=microk8s.kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=-f

deploy: secret service deployment
	@echo "done"
clean: clean-deployment clean-service clean-secret
	@echo "done"

%:
	$(KC) apply -f $*.yaml 

clean-%:
	$(KC) delete -f $*.yaml 2>/dev/null || echo "nothing to do"

logs:
	$(KC) wait --for condition=Ready pod -l app=$(DEPLOYMENT) --timeout=-1s && \
	$(KC) logs deployment/$(DEPLOYMENT) $(LOGFLAGS)

list:
	$(KC) get pods -l app=$(DEPLOYMENT)

exec:
	$(KC) exec -it deployment/$(DEPLOYMENT) -- bash
