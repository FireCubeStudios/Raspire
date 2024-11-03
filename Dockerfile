# Use the official .NET 8 SDK image as a base
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container to /app
WORKDIR /app

# Copy the entire project
COPY . ./

# Update installed .NET workloads
RUN dotnet workload update

# Install the .NET Aspire workload
RUN dotnet workload install aspire

# Restore dependencies
RUN dotnet restore

# Expose ports the .NET Aspire website runs on
EXPOSE 16003
EXPOSE 19238
EXPOSE 20237

# Run the .NET Aspire website
CMD ["dotnet", "run", "--project", "Raspire/Raspire.csproj"]
