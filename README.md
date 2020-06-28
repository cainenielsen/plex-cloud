# plex-cloud

This project will use Google Cloud Run, Google Cloud Storage, and Google Cloud Store FUSE to create a serverless Plex media server that is able to access cloud hosted media and will feature a secondary file upload landing page that supports selecting between different media folders available.

# Architecture

See the Plex Media Server Docker image
https://hub.docker.com/r/linuxserver/plex

We will be customizing the above Docker container image to our liking, then we will submit it to the container registery.

See Google Cloud Container Registry
https://cloud.google.com/container-registry

We will be submitting our images to be stored within the registry, then we will be able to load them into Cloud Run machines.

See Google Cloud Run
https://cloud.google.com/run

Cloud Run will support two containers, one for the Plex Media Server, and another for the file upload web application.

Google Cloud Run automatically scales containers to accomedate for traffic, this does not pertain to media outside of the container.

See Google Cloud Storage
https://cloud.google.com/storage

The media server will be looking for files within selected media folders on the machine, the files include photos, videos, and more.

Note: Cloud Storage is "Object Storage" and by default cannot be accessed as a network mapped drive.

See Google Cloud Storage FUSE 
https://cloud.google.com/storage/docs/gcs-fuse

The bring object storage from Google Cloud Storage into the Plex Media Server, we will need to use FUSE to create a file system service that we can then connect to from within the Cloud Run container.

Note: FUSE is a Google library, but is open source.

# Steps

## Google Cloud PLatform

1. Navigate to the Google Cloud Platform Console.
https://console.cloud.google.com/

2. Create a new Google Cloud Platform project.
https://console.cloud.google.com/projectcreate

3. Install the Google Cloud CLI. 
Windows: https://cloud.google.com/sdk/docs/downloads-interactive
Linux: Use apt-get

4. Initialize the Google Cloud CLI.
gcloud init

5. Check which project you have selected.
gcloud config get-value project

## Plex Media Server Container Images
See more details here: https://hub.docker.com/r/linuxserver/plex

1. Install Docker.
Windows: https://docs.docker.com/docker-for-windows/install/

2. Launch Docker and Docker Desktop.

3. Use the docker CLI to pull the Plex Media Server Container Image from Docker Hub. 
docker pull linuxserver/plex

4. Navigate to https://www.plex.tv/claim/ and generate a claim token.

5. docker run -dp 80:80 linuxserver/plex

## Web App Container Image
See tutorial here: https://cloud.google.com/run/docs/quickstarts/build-and-deploy

1. Create a Cloud Run package, featuring a package.json file.

2. Create a custom script to be added to the image. (index.js)

3. Create a Dockerfile that outlines Docker instructions.

4. Create .dockerignore file to automatically ignore uneeded development files.

5. Submit the image to the Google Cloud Container Registry.
gcloud builds submit --tag gcr.io/project-id/image-id

6. Navigate to the registry to view the image.
https://console.cloud.google.com/gcr/images/project-id

7. Using the drop down, click "Deploy to Cloud Run".

## Cloud Run

1. Navigate to the Cloud Run page within the GCP Console.
https://console.cloud.google.com/run

2. Under "Deployment platform", choose "Cloud Run (fully managed)"

3. Name your service.

4. Select "Allow unauthenticated invocations".

5. Click "Next".

6. Enter your Plex Media Server - Google Cloud Container Registry - URL.

Watch this Docker tutorial: https://www.youtube.com/watch?v=fqMOX6JJhGo
