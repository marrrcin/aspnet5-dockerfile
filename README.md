# aspnet5-dockerfile
Dockerfile which can be used to build fully functional ASP.NET vNext application as a Docker Container.

## Usage
1. Put *Dockerfile* inside of your ASP.NET vNext project where you have Startup.cs and project.json files.
2. Run the command `docker build -t yourProjectName .`
3. If your project contains dependencies to lots of libraries such as MVC, go get some coffee.
4. To launch the web application execute command `docker run -t -d -p [PORT]:5004 yourProjectName`
5. You're now live on the specified [PORT].

## How to stop the vNext app on linux
1. Execute `docker ps` and identify your app container id.
2. Execute `docker stop [container id]`

## How to quickly restart vNext app on linux
1. Execute `docker ps` and identify your app container id.
2. Execute `docker restart -t=1 [container id]`

## Tip
If you want to perform a quick fix inside of the running app, follow the steps:

1. Execute `docker ps` to see the list of running apps. Identify your app container id.
2. Run `docker exec -i -t [container id] /bin/bash`
3. You are now in the bash console inside of your container. To exit bash, just `exit`.
4. Restart the app (see previous paragraph).

## Problems with layout and _ViewStart.cshtml ?
I've came accross the problem, where I've finally ran the application, but it has no styling. The issue was the naming of the _ViewStart.cshtml file. Solution?

1. Rename `_ViewStart.cshtml` from ViewsFolder to `_viewstart.cshtml`

## Command *k kestrel* not found in the container?
This is another issue which effectively stopped me for a while when I tried to build the app. It was caused by missing command in *project.json*.

1. Make sure your *commands* section in `project.json` looks like this:
```
"commands": {
        "web": "Microsoft.AspNet.Hosting --server Microsoft.AspNet.Server.WebListener --server.urls http://localhost:5000",
        "gen": "Microsoft.Framework.CodeGeneration",
        "ef":  "EntityFramework.Commands",
        
        /* kestrel command is required when you run app on linux */
        "kestrel": "Microsoft.AspNet.Hosting --server Kestrel --server.urls http://localhost:5004"
        
    },
```
