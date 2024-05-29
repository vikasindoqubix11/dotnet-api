# Use the official .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /source

# Copy the project file into the container
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the files into the container
COPY . ./

# Build the application
RUN dotnet publish -c Release -o /app/out  # Output directory should be /app/out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the published output from the build stage into the runtime image
COPY --from=build /app/out .  # Copy from the correct path

EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "WebApplication-cloud.dll"]
