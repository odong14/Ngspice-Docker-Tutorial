# Ngspice Docker Tutorial

This tutorial explains how to build the ngspice Docker image, mount a folder from Windows, and run `inv.cir` inside the container.

## 1. Install Docker Desktop

Download and install Docker Desktop:

[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

Open Docker Desktop and wait until it is running.

## 2. Clone this repository

Open a terminal and clone the repository. Replace the placeholders with the repository URL and folder name:

```bash
git clone https://github.com/odong14/Ngspice-Docker-Tutorial
cd Ngspice-Docker-Tutorial
```

Run the following commands from the repository folder that contains the `Dockerfile`.

## 3. Build the Docker image

Build the image and wait for the process to finish:

```bash
docker build -t ngspice .
```

Confirm that the image was created:

```bash
docker images
```

The image should appear as `ngspice` with the tag `latest` (`ngspice:latest`).

## 4. Create a container and mount a shared folder

Create a folder on the Windows host for the circuit file, model files, and output. For example:

```text
D:\KFUPM\Part_Time\VLSI\HW1
```

In the Docker volume argument, write the Windows path with forward slashes. Update the host path below if your shared folder is somewhere else. The path after the colon, `/project`, is the folder inside the container.

```bash
docker run -it -d -v "D:/KFUPM/Part_Time/VLSI/HW1:/project" ngspice:latest
```

Wait for the command to finish. Copy `inv.cir` and `sky130.7z` into the Windows shared folder, then extract `sky130.7z` in that same folder. The extracted files will also be available inside the container under `/project`.

## 5. Start the container

List all containers and find the container created in the previous step:

```bash
docker ps -a
```

Copy its value from the `CONTAINER ID` column, then start and attach to it. Replace `CONTAINER_ID` with the actual ID:

```bash
docker start -ai CONTAINER_ID
```

## 6. Run the circuit

At the container terminal, go to the shared folder and run ngspice:

```bash
cd /project
ngspice inv.cir
```

If the circuit runs successfully and its commands generate an SVG plot, the SVG file will be saved in `/project`. Because `/project` is shared with the Windows folder, you can find the output there on the host as well.
