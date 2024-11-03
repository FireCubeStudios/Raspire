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

# Build the project
RUN dotnet publish ./Raspire/Raspire.csproj -c Release -o out

# Use the .NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expose the port the .NET Aspire website runs on
EXPOSE 80

# Set the entry point for the .NET Aspire website
ENTRYPOINT ["dotnet", "raspire.dll"]
