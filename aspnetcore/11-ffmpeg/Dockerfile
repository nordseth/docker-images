FROM mcr.microsoft.com/dotnet/aspnet:11.0-resolute

RUN apt-get update && \
    apt-get install -y ffmpeg libvidstab1.1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*