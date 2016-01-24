# redmine-all-in-one

No need another steps to use Redmine with docker!

Including SVN & Git hosting!

## start

[Setup docker engine](https://docs.docker.com)

```
docker run --name redmine --restart=unless-stopped -p 80:80 74th/redmine-all-in-one
```

## feature

* Redmine 3.2
* hosted subversion repository : http://dockerhost/svn/
* hosted git repository : http://dockerhost/git/
* include database
* include plugins for agile develop

## included plugins

* [SCM Creator](http://www.redmine.org/plugins/redmine_scm) (GPLv2)
    * https://github.com/ZIMK/scm-creator
* [Backlogs](http://www.redminebacklogs.net/) (GPLv2)
    * https://github.com/backlogs/redmine_backlogs
* [Issue template](http://www.redmine.org/plugins/issue_templates) (GPLv2)
* [Code Review](http://www.redmine.org/plugins/redmine_code_review) (GPVv2)

## problem

* subversion is able to be created at only creating a project
* need a step for setup backlogs 

## next...

* [People](http://www.redmine.org/plugins/redmine_code_review)

