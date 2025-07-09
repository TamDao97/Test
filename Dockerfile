# ----- Build Stage -----
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY test/test.csproj ./test/
RUN dotnet restore ./test/test.csproj

COPY . .
RUN dotnet publish ./test/test.csproj -c Release -o /app

# ----- Runtime Stage -----
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "test.dll"]
