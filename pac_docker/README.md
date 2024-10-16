
# PowerApps CLI Docker Image

This repository provides a Dockerfile to create a Docker image with the Microsoft PowerApps CLI (`pac`) installed. The image allows you to use the PowerApps CLI in a containerized environment, enabling consistent and portable development workflows across different machines and platforms.

---

## tl;dr

You now have a Docker image with the PowerApps CLI installed, enabling you to manage Power Platform environments and solutions in a consistent, containerized environment. By following this guide, you can:

- Build and run the Docker image on both Linux and Windows machines.
- Authenticate and interact with your Power Platform environments.
- Share files between your host and the container for seamless development.
- Customize the Docker image to suit your specific needs.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Dockerfile Overview](#dockerfile-overview)
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container](#running-the-docker-container)
  - [Interactive Shell](#interactive-shell)
  - [Running Commands Directly](#running-commands-directly)
- [Authenticating with Power Platform](#authenticating-with-power-platform)
- [Using the PowerApps CLI](#using-the-powerapps-cli)
- [Sharing Files Between Host and Container](#sharing-files-between-host-and-container)
- [Customizing the Docker Image](#customizing-the-docker-image)
- [Cleaning Up Resources](#cleaning-up-resources)
- [Additional Resources](#additional-resources)

---

## Prerequisites

- **Docker Installed:**
  - **Ubuntu/Linux:**
    - Install via script:

      ```bash
      curl -fsSL https://get.docker.com -o get-docker.sh
      sudo sh get-docker.sh
      ```

    - Or install via APT:

      ```bash
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
      ```

  - **Windows:**
    - Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/).
    - Ensure WSL 2 is enabled for Linux containers.

- **Docker Daemon Running:**
  - Verify with `docker info` or `docker version`.

---

## Dockerfile Overview

The Dockerfile uses the official .NET SDK image and installs the PowerApps CLI as a global tool.

```dockerfile
# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Install PowerApps CLI using dotnet tool
RUN dotnet tool install --global Microsoft.PowerApps.CLI.Tool --version 1.35.1

# Add dotnet tools to the PATH
ENV PATH="$PATH:/root/.dotnet/tools"

# Optional: Set the working directory
WORKDIR /workspace
```

---

## Building the Docker Image

1. **Clone the Repository or Create Dockerfile:**

   - If you have this content in a repository, clone it.
   - Or, create a new file named `Dockerfile` and copy the contents from the Dockerfile above.

2. **Open a Terminal in the Directory Containing the Dockerfile.**

3. **Build the Docker Image:**

   ```bash
   docker build -t pac_docker .
   ```

   - **`-t pac_docker`**: Tags the image with the name `pac_docker`.
   - **`.`**: Specifies the build context as the current directory.

---

## Running the Docker Container

### Interactive Shell

To interactively use the PowerApps CLI inside the container:

```bash
docker run -it pac_docker bash
```

- **`-it`**: Runs the container in interactive mode with a TTY.
- **`bash`**: Starts a Bash shell inside the container.

### Running Commands Directly

To execute `pac` commands without an interactive shell:

```bash
docker run --rm pac_docker pac --version
```

- **`--rm`**: Automatically removes the container after execution.
- **`pac --version`**: The command to run inside the container.

---

## Authenticating with Power Platform

Before using the PowerApps CLI to manage environments and solutions, you need to authenticate.

1. **Start the Container:**

   ```bash
   docker run -it pac_docker bash
   ```

2. **Create an Authentication Profile:**

   ```bash
   pac auth create --name MyProfile
   ```

   - The CLI will provide a device login code and URL.

3. **Authenticate via Browser:**

   - Open a browser on your host machine.
   - Navigate to [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin).
   - Enter the code provided by the CLI.
   - Log in with your Microsoft account credentials.

4. **Verify Authentication Profiles:**

   ```bash
   pac auth list
   ```

5. **Select Active Profile (if necessary):**

   ```bash
   pac auth select --name MyProfile
   ```

---

## Using the PowerApps CLI

With authentication set up, you can now use `pac` commands.

**Examples:**

- **Check `pac` Version:**

  ```bash
  pac --version
  ```

- **List Environments:**

  ```bash
  pac org list
  ```

- **Export a Solution:**

  ```bash
  pac solution export --name YourSolutionName --output ./YourSolution.zip
  ```

- **Import a Solution:**

  ```bash
  pac solution import --path ./YourSolution.zip
  ```

- **Create a New Canvas App:**

  ```bash
  pac canvas create --name "MyNewApp" --template "Blank"
  ```

---

## Sharing Files Between Host and Container

To work with files from your host machine (e.g., solution files), mount a volume when running the container.

**Mount a Volume:**

```bash
docker run -it -v /path/on/host:/workspace pac_docker bash
```

- **`-v /path/on/host:/workspace`**: Mounts the host directory to `/workspace` inside the container.

**Example on Linux/Mac:**

```bash
docker run -it -v ~/Projects/PowerAppsSolution:/workspace pac_docker bash
```

**Example on Windows (PowerShell):**

```powershell
docker run -it -v C:\Projects\PowerAppsSolution:/workspace pac_docker bash
```

**Accessing Mounted Files:**

Inside the container, navigate to `/workspace`:

```bash
cd /workspace
ls
```

---

## Customizing the Docker Image

You can extend the Dockerfile to include additional tools or dependencies.

**Example: Install Node.js and npm**

Add the following to your Dockerfile before the `WORKDIR` instruction:

```dockerfile
# Install Node.js and npm
RUN apt-get update &&     apt-get install -y nodejs npm &&     rm -rf /var/lib/apt/lists/*
```

**Rebuild the Image:**

```bash
docker build -t pac_docker .
```

---

## Cleaning Up Resources

To free up system resources, you can remove unused containers and images.

**List All Containers:**

```bash
docker ps -a
```

**Remove a Container:**

```bash
docker rm container_id_or_name
```

**Remove the Image:**

```bash
docker rmi pac_docker
```

**Prune Unused Resources:**

```bash
docker system prune
```

---

## Additional Resources

- **PowerApps CLI Documentation:**
  - [Microsoft Docs - Power Platform CLI](https://learn.microsoft.com/power-platform/developer/cli/introduction)
- **Docker Documentation:**
  - [Get Started with Docker](https://docs.docker.com/get-started/)
- **Dockerfile Best Practices:**
  - [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
- **Authentication with Device Login:**
  - [Microsoft Identity Platform - Device Code Flow](https://learn.microsoft.com/azure/active-directory/develop/v2-oauth2-device-code)

---

If you have any questions or need further assistance, feel free to reach out!
