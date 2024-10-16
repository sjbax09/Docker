FROM mcr.microsoft.com/dotnet/sdk:8.0

# Install PowerApps CLI using dotnet tool
RUN dotnet tool install --global Microsoft.PowerApps.CLI.Tool --version 1.35.1

# Add dotnet tools to the PATH
ENV PATH="$PATH:/root/.dotnet/tools"
