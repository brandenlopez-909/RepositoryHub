# Showwcase Data Analysis: User Engagement

## I. Introduction and Motivation
Showwcase is a platform tailored to the tech community, in Showwcase a user can share projects and explore others. Showwcase provides many ways to interact and in the data set provided for October 2019, "user engagement" is tracked by logins. Events within each login duration are recorded. With the aim of understanding user engagement in Python, we must first define "user engagement". Deriving my definition of user engagement from [Mixpanel](https://mixpanel.com/topics/what-is-user-engagement/), user engagement is defined by interactions such as likes and comments, and time actively spent the platform.

Since user engagement is important for brand expansion and increasing revenues. It is because of this, metrics of how users are engaged are imperative to success of platforms.  

## II. Data and Exploration 

### 1. Data Enhancement
Using libraries from Python, data integrity was verified and data enhancement began. The data set can be manipulated from existing variables, one thing that I noticed was multiple logins. Using user identification numbers and data of login, we are able to produce a new user engagement metric that tells how many logins a user had each day. This is useful because multiple logins could be used to indicate addictivness. 

In addition to this, the descriptions of each variable led me to believe that a true active time on the platform could be found. To produce this new variable, we subtract  **inactive_duration** from **session_duration**, only to find many negative value in the new variable. This happens because the sum of **session_duration** and **inactive_duration** are most likely the total time. Thus, the definition of **session_duration** should be changed from, "number of seconds a user was logged for that session" to "number of seconds a user was actively logged for that session". It's important to know that this speculation and many other reasons could attribute to negative values. For instance, the algorithm for recording the times could be broken. 

After implementing any controllable user enhancements, I began to think of variable categories and my time on Showwcase. The variables while different are 4 things, unique identifiers, profile updates, user-to-user engagement, and time spent. 

The only metric to record a user updating their profile is **projects_added**. Despite this, Showwcase allows the user to update the profile by updating external links, profile pictures, badges, experinces, articles, and an about me section. In addition, the data set's user-to-user variables are limited to likes and comments and can be expanded to, followers added, visited user pages, and clicks on external links. Lastly, we don't know how long a user engages in profile updates, reads projects, articles, and exploring other user profiles. By adding all mentioned variables, user engagement can more be more efficently tracked. 

### 2. Data Exploration 
Using Python, the data was visulized and descriptive statistics were explored. Since the data set is small, exploration for seasonaility trends are ignored. Instead, I aimed to explore the realtionship of each variable. The heat map in **Figure 1** shows that the correlation between variables is weak. 

![Figure 1](/pictures/HeatMap.png)
