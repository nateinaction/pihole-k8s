GCP_PROJECT_ID = worldpeaceio-production
GCP_SECRET_KEY = pihole
SECRETS_FILE = config/secrets.yaml
SECRET_VERSION = 2
IMAGE = nateinaction/pihole

.PHONY: clean
clean:
	rm $(SECRETS_FILE)

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE) .

.PHONY: docker-push
docker-push: docker-build
	docker push $(IMAGE)

$(SECRETS_FILE):
	gcloud secrets versions access $(SECRET_VERSION) --secret=$(GCP_SECRET_KEY) --project=$(GCP_PROJECT_ID) > config/secrets.yaml

.PHONY: update-secret
update-secret:
	gcloud secrets versions add $(GCP_SECRET_KEY) --data-file=$(SECRETS_FILE) --project=$(GCP_PROJECT_ID)

.PHONY: deploy
deploy: $(SECRETS_FILE)
	kubectl apply -k config/
