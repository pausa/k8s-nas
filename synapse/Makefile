KC=kubectl
DEPLOYMENT=$(shell basename $(PWD))
LOGFLAGS=--all-containers -f
BRIDGES=$(wildcard ../synapse-*)

ADMIN_USER=@gooduser:serveraddress
ACCESS_TOKEN=goodtoken
CLEAN_USER=usegooduser

deploy: service deployment
	@echo "done"

undeploy: clean-deployment
	@echo "done"

clean: clean-deployment clean-service
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

redeploy-bridges: 
	for bridge in $(wildcard ../synapse-*); do \
		$(MAKE) -C $$bridge undeploy deploy; \
	done 

create-password:
	$(KC) exec -it deployment/synapse -c synapse -- hash_password -c /data/homeserver.yaml

check-password:
	$(KC) exec -it deployment/postgres -- psql synapse -c "select password_hash from users where name = '$(ADMIN_USER)'"

update-password:
	$(KC) exec -it deployment/postgres -- psql synapse -c "update users set password_hash = '"'passwordahash'"' where name = '$(ADMIN_USER)'"

list-users:
	$(KC) exec -it deployment/postgres -- psql synapse -c "select * from users where name not like '%telegram%' and name not like '%whatsapp%' and name not like '%instagram%' and name not like '%googlechat%' limit 10"

set-admin:
	$(KC) exec -it deployment/postgres -- psql synapse -c "update users set admin = 1 where name = '$(ADMIN_USER)'"

unset-admin:
	$(KC) exec -it deployment/postgres -- psql synapse -c "update users set admin = 0 where name = '$(ADMIN_USER)'"


login-admin:
	$(KC) exec -it deployment/synapse -c synapse -- curl -XPOST \
		-d '{"type":"m.login.password", "user":"$(ADMIN_USER)", "password":"properpassword"}' \
		"http://localhost:8008/_matrix/client/r0/login"

delete-media:
	$(KC) exec -it deployment/synapse -c synapse -- curl -XDELETE \
		-H "Authorization: Bearer $(ACCESS_TOKEN)" \
		"http://localhost:8008/_synapse/admin/v1/users/$(CLEAN_USER)/media"

delete-all-media:
	$(KC) exec -it deployment/synapse -c synapse -- curl \
		--header "Authorization: Bearer $(ACCESS_TOKEN)" \
		--request POST \
		"http://localhost:8008/_synapse/admin/v1/media/madpausa.sytes.net/delete?before_ts=$$(date +%s%3N)"
