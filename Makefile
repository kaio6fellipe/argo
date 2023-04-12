include help.mk

version?=development

dockerenv=--env GROUP_ID="$(shell id -g $$USER)" \
  --env USER_ID="$(shell id -u $$USER)" \
  --env KEY_FILE
base_imagename=ghcr.io/kaio6fellipe/terraform-devops/platform-ops
development_imagename=$(base_imagename):development

docker_run=docker run --rm $(dockerenv) --volume `pwd`:/platform --volume ~/.aws:/root/.aws $(base_imagename):$(version)
docker_run_interactive=docker run --rm $(dockerenv) --volume `pwd`:/platform --volume ~/.aws:/root/.aws --tty --interactive $(base_imagename):$(version)

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "argument '$*' is required"; \
		exit 1; \
	fi

.PHONY: run
run: ##@docker Run the container image used for local development and operation
	$(docker_run_interactive) /bin/bash