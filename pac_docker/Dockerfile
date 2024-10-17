# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Install PowerApps CLI using dotnet tool and specify the installation path
RUN dotnet tool install --tool-path /usr/local/bin Microsoft.PowerApps.CLI.Tool --version 1.35.1

# Optional: Set the working directory
WORKDIR /workspace
