# 8 step process: Programming with AI

The 8 step process is a systematic approach to programming with AI. It helps ensure that the AI is used effectively and efficiently.

This is a multi-app planning process, capable of planning an ecosystem of apps that share common resources as authentication, database, etc. The process starts with a high level system architecture, then goes into the app level architecture, then the feature level architecture, then the code level architecture.

Planning folder structure:

```
└── planning/
    ├── rules/
    │   ├── system_manifesto.md
    │   ├── system_architecture.md
    │   ├── ui/
    │   │   ├── system_styleguide.md
    │   │   └── inspirations/
    │   ├── app1/
    │   ├── app1_manifesto.md
    │   ├── app1_architecture.md
    │   ├── ui/
    │   │   ├── app1_styleguide.md
    │   │   └── inspirations/
    │   └── features/
    │       ├── feature1/
    │       │   └── feature11.md
    │       └── feature2/
    │           └── feature21.md
    └── app2/
        ├── app2_manifesto.md
        ├── app2_architecture.md
        ├── ui/
        │   ├── app2_styleguide.md
        │   └── inspirations/
        └── features/
            ├── feature1/
            │   └── feature21.md
            └── feature2/
                └── feature22.md
    .
    .
    .

    └── appN/
        ├── appN_manifesto.md
        ├── appN_architecture.md
        ├── ui/
        │   ├── appN_styleguide.md
        │   └── inspirations/
        └── features/
            ├── feature1/
            │   └── featureN1.md
            └── feature2/
                └── featureN2.md
```


## Step 0: Planning initialization

The planning process starts with the planning initialization step. It creates the planning folder.

#### Command: /project:planning:initialize

The command is `/project:planning:initialize`. It takes the ARGUMENT with values `single` or `multi`. 

#### Output: 

The command does the following:

1. Creates the planning folder and the rules folder
2. If the ARGUMENT is `single`, creates the app folder and the app_manifesto.md file and the ui folder with the inspirations folder
3. If the ARGUMENT is `multi`, creates the system_manifesto.md file and ui folder with the inspirations folder



## Step 1: Overall multiapp/singleapp manifesto and architecture

There are 2 possible commands the user can use to start the planning process, depending on whether there are multiple apps or not:

1. `/project:planning:multiapp_architecture` - for multiple apps
2. `/project:planning:singleapp_architecture` - for a single app

### System architecture

This step is the first step in the planning process. It is a high level overview of the system architecture including decisions like monorepo or polyrepos, shared resources, microservices, deployment strategy, etc. 

#### Input: system_manifesto.md

The input is a markdown file that contains the system manifesto. The user describes which apps compose the system and what they do and how they interact with each other. There are no technical details in this file.

#### Command: 

The command is `/project:planning:multiapp_architecture` with optional argument `system_name` if the user wants to give a name to the system.

#### Output: system_architecture.md

The command does the following:

1. Create a system architecture file in `planning/system_architecture.md`
2. Defines the apps in the system and creates the apps folders with app1, app2, etc.
3. For each app: 
   - Creates an empty app manifesto file
   - Creates an empty ui folder with the inspirations folder
   - Creates an empty features folder

Then the user can start with the application architecture step.

### Application architecture

This step is a high level overview of the application architecture for a given app in the system. It needs to confine the the overall system architecture and the app manifesto, if any.

#### Input: appName_manifesto.md

The input is a markdown file that contains the app manifesto. The user describes what the app does. There are no technical details in this file.

#### Command: 

The command is `/project:planning:singleapp_architecture` with required argument `appN`, pointing at the app folder you want to create/plan.

#### Output: appN_architecture.md

The command does the following:

1. Create an app architecture file in `planning/appN/appN_architecture.md`
2. Creates the app features folder, if it doesn't already exist
3. Creates the app ui folder with the inspirations folder, if it doesn't already exist




