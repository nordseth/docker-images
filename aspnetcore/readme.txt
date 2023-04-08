rootless aspnetcore runtime image

From 7.0 we see to Microsoft how to do non-rootless

https://devblogs.microsoft.com/dotnet/dotnet-6-is-now-in-ubuntu-2204/#non-root-images

RUN groupadd \
        --system \
        --gid=101 \
        app \
    && adduser \
        --uid 101 \
        --gid 101 \
        --shell /bin/false \
        --no-create-home \
        --system \
        app
        
From dotnet 8 the default images come with app user already setup, see https://devblogs.microsoft.com/dotnet/securing-containers-with-rootless/
