# QuickStart

## Importing the s2i-boot Builder

- Importing the s2i-boot builder

  ```
  $ oc create -f https://raw.githubusercontent.com/linzhaoming/s2i-boot/master/openshift/s2i-boot-imagestream.json

  imagestream "s2i-boot" created
  ```

- Importing the template example

  ```
  oc create -f https://raw.githubusercontent.com/linzhaoming/s2i-boot/master/openshift/template-springboot-helloworld.json

  template "example-s2i-boot" created
  ```

  ​

## Creating from **s2i-boot** Templates Using the Web Console

To create the objects from an uploaded template using the web console:

1. While in the desired project, click Add to Project:


![Add](images/addToProject.png)

2. Select a template from the list of templates in your project, or provided by the global template library:

- Selectt **Java** Template

![Select](images/select.png)

- Select **example-s2i-boot**

![SelectTemplate](images/selectTemplate.png)

3. Modify template parameters in the template creation screen:

![New App](images/new-app.png)

Click  the  **Create** Button 
4. You should see the result like this

![Result](images/result.png)

## Creating from Templates Using the CLI

- Using the CLI to deploy the new app

```
[root@centos-51 ~]# oc new-app example-s2i-boot
--> Deploying template "nemo/example-s2i-boot" to project nemo

     example-s2i-boot
     ---------
     s2i-boot: Sample SpringBoot Application

     * With parameters:
        * Application name=springboot-helloworld
        * Jar file suffix=
        * Maven Mirror URL=http://maven.aliyun.com/nexus/content/groups/public
        * Application hostname=
        * GIT_URI=https://github.com/linzhaoming/springboot-helloworld.git
        * GIT_REF=master
        * CONTEXT_DIR=
        * APP_OPTIONS=
        * GITHUB_TRIGGER_SECRET=54uB6vkL # generated
        * GENERIC_TRIGGER_SECRET=t8TTWiqG # generated

--> Creating resources ...
    buildconfig "springboot-helloworld" created
    imagestream "springboot-helloworld" created
    deploymentconfig "springboot-helloworld" created
    route "springboot-helloworld" created
    service "springboot-helloworld" created
--> Success
    Build scheduled, use 'oc logs -f bc/springboot-helloworld' to track its progress.
    Run 'oc status' to view your app.
```

