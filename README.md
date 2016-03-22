# MediaNet Software's Jira Rest API Objective-C Client
--------------


# What?
Open source library under LGPLv3 license,  that facilites access to [Atlassian´s](https://www.atlassian.com/) [Jira](https://www.atlassian.com/software/jira) [Rest API](https://docs.atlassian.com/jira/REST/latest/), for software developed for iOS and Mac OS.

# Why?
Nowadays, Atlassian´s Jira plataform is widely used for software management and issue tracking. This library has been build focusing on offer an easy access for applications based on Apple systems to the public API.

# How I get it?
It is available from this repository. The project is built as library .a to be added to your current project or workspace.
It will be added to [CocoaPods](http://cocoapods.org/) nearly.

# How it works?
The library access point is the class **MNSJiraRestClient**. This class represents access to the API by the clients that implements each funcionality.

- **MNSIssueRestClient** - Access to issue management. Creates and gets issues.
- **MNSSearchRestClient** - Access to search on Jira, using filters.
- **MNSComponentRestClient** - Access to components of a project.
- **MNSProjectRestClient** - Access to project management.
- **MNSUserRestClient** - Access to users search by email, name or uri.
- **MNSVersionRestClient** - Access to version project.

*MNSJiraRestObjectiveCClient* permits anonymous access and private access too.

NOTE: It is currently ussing [AFNetWorking 3.0](http://afnetworking.com/) by CocoaPods. So must run pod install from terminal.
    

# How do I test it?
The library has attached several tests for internal rest clients.

# Who did it?
MediaNet Software's Mobility department [MediaNet Software](http://www.medianet.es).