# ----- Build Stage -----
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy csproj và restore
COPY test/test.csproj ./test/
RUN dotnet restore ./test/test.csproj

# Copy toàn bộ và publish
COPY . .
RUN dotnet publish ./test/test.csproj -c Release -o /app

# ----- Runtime Stage -----
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "test.dll"]
