# Purpose
Some notes and basic content on dockerhub automated builds for a forgetful mind

Note building images using dockerhub automated builds is not very fast, this is fine for one-offs and custom images



# Prerequisites
- You have a dockerhub account, see [here](https://hub.docker.com/) to create a free account option
- You have a hosted repository service, see [bitbucket](https://bitbucket.org/), [github](https://github.com/) or [gitlbab](https://about.gitlab.com/) for free account options
- Will need to grant dockerhub [access](https://docs.docker.com/docker-hub/github/#linking-docker-hub-to-a-github-account) to your hosted repository service, I did this with github.com and was able to grant "Limited access" rather "Public and Private Access"



# Github repo preparation
- Create repo or open existing repo
- Pick settings at the top
- Select "Integrations & services" option
- Hit "Add service" and select "Docker" from list
- Hit "Add service" and your done



# Dockerhub repository preparation
- On top of screen hit Create -> "Create Automated Build"
- Pick github button
- Select repo
- Hit Create

Note: Do not create the dockerhub repository first, the create automated build creates the dockerhub repository and will fail at this time, see [issue](https://github.com/docker/hub-feedback/issues/450#issuecomment-15509724://github.com/docker/hub-feedback/issues/450#issuecomment-155097245)



# Repo content
- Will need a Dockerfile
	- This repo has a simple script that is a loop echoing the version and a sequence number
	- Used docker multistage build file, so I could include the version in the script as part of the image build, this is silly but I need something similar for golang based images
- reaadme.md will appear in the dockerhub repository page
- I am using docker automated build [hooks](https://docs.docker.com/docker-cloud/builds/advanced/#custom-build-phase-hooks) to allow me do some dynamic labelling and tagging
	- Created a hooks/build - this contains a script that wraps the docker build command - will create an image with latest tag
	- Created a hooks/post_push - this allows me to tag the just created image
- Could have used git [tags or branches](https://docs.docker.com/docker-hub/builds/) for tagging the image, would make thehook/post_push redundant
- Could have added tests also, see [here](https://docs.docker.com/docker-cloud/builds/advanced/#override-build-test-or-push-commands)



# Docker image info
- Rather than pulling the image there are tools that can give you some of this info, see [MicroBadger](https://microbadger.com/images/pmcgrath/dhab)
- To view and run locally

```
# Lets pull the image
docker image pull pmcgrath/dhab:0.1

# Lets examine the labels
docker image inspect pmcgrath/dhab:0.1 | jq .[0].Config.Labels

# Run an instance - Do you trust this content ? Should view the dockerfile or examine content, could be doing anything !
docker container run --read-only pmcgrath/dhab:0.1
```
