# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Create a directory for dotnet tools
RUN mkdir -p /opt/dotnet-tools

# Install PowerApps CLI to /opt/dotnet-tools
RUN dotnet tool install --tool-path /opt/dotnet-tools Microsoft.PowerApps.CLI.Tool --version 1.35.1

# Create a symlink to 'pac' in '/usr/local/bin'
RUN ln -s /opt/dotnet-tools/pac /usr/local/bin/pac

# Optional: Set the working directory
WORKDIR /workspace
