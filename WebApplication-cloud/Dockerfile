# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /source

# Copy the project file into the container
COPY ./WebApplication-cloud/*.csproj ./
RUN dotnet restore

# Copy the rest of the files into the container
COPY ./WebApplication-cloud .

# Build the application
RUN dotnet publish -c Release -o /app --no-restore

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "WebApplication-cloud.dll"]
