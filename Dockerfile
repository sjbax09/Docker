# Use the .NET 7.0 SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Create a directory for dotnet tools
RUN mkdir -p /opt/dotnet-tools

# Install an earlier version of PowerApps CLI
RUN dotnet tool install --tool-path /opt/dotnet-tools Microsoft.PowerApps.CLI.Tool --version 1.21.6

# Create a symlink to 'pac' in '/usr/local/bin'
RUN ln -s /opt/dotnet-tools/pac /usr/local/bin/pac

# Optional: Set the working directory
WORKDIR /workspace
