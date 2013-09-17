# Case Study: Grails in the Real World

This is the code repository for my talk at Spring One 2GX 2013.

To run the code follow these steps:

1. Install MongoDB for file caching.

2. Download and launch the proxy Grails app:

```
$ git clone https://github.com/gregturn/grails-real-world
$ cd grails-real-world
$ grails run-app
```

It was built with Grails 2.2.3, so if your version is different, you might run into issues.

3. In another shell, go to the sample app that uses the proxy.

```
$ cd grails-real-world/sample-app
$ mvn clean package
```

4. Clean out your maven repository's spring-web artifacts.

```
$ cd ~/.m2/repository/org/springframework/
$ rm -rf springweb*
```

5. Finally, run the app.

```
$ java -jar target/gs-rest-hateoas-0.1.0.jar
```

The sample app should fetch spring-web artifacts through the proxy app.

> **Note:** See the slides at https://speakerdeck.com/gregturn/springone-2gx-2013-case-study-grails-in-the-real-world.
