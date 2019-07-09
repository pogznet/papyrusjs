# PapyrusJS Docker Image

## WORK IN PROGRESS

Clean this up after testing

## What you need to run

```
docker run -d -p 8080:80 \
    -v /local/minecraft/world/directory:/MyWorld \
    -v /local/directory/for/webfiles:/usr/local/apache2/htdocs/ \
    papyrusjs
```

## Environment variables (NOT APPLICABLE YET)

`LEVEL_NETHER` (1 or 0) to render nether or not 
`LEVEL_END` (1 or 0) to render end level or not 
`CONFIG_THREADS`
`CONFIG_OUTFILE`
`CONFIG_QUALITY`

See default values and accepted parameters in https://github.com/clarkx86/papyrusjs

## Under the hood

### The Dockerfile
Insitalls the dependencies and the application itself and calls the `entrypoint.sh` script which enables cron, generate map and lastly the httpd-foreground.

### The `generate_map.sh` script
Starts off by printing the date and cleaning up the current world directory (dont worry this will not clean up your existing Minecraft world) and copies the working map (existing Minecraft world) to the current directory [1].  then runs the PapyrusCs application. This should log something in `/var/log/generate_map.log` so you could get back to checking it in the future.

[1] Why are we doing this? This is due to an issue I filed in https://github.com/mjungnickel18/papyruscs/issues/10 

## Other stuff
I am not an expert in Dockerizing services so please do cut me some slack if you're going to use this in your deployment. I provide no support whatsoever on this script and while its poorly written, it functions to perform what I need. 

I dont know how often the PapyrusJS team updates their code, so it is possible that the file being downloaded here is an old version. I will update it when I have the time.

Recent tests with eagle on the PapyrusJS Discord channel pegged that a 60mbish world should render about 5-6 minutes with around 1Gb RAM.