# redmine-all-in-one

No need other steps to use Redmine with docker!

Including SVN & Git hosting!

* https://hub.docker.com/r/74th/redmine-all-in-one/
* https://github.com/74th/docker-redmine-all-in-one

## start

Setup docker engine https://docs.docker.com/engine/installation/

```docker run -d --name redmine --restart=unless-stopped -p 80:80 74th/redmine-all-in-one```

access http://dockerhost/

* user: admin
* password: admin

### 日本語初期データ込み

```docker run -d --name redmine --restart=unless-stopped -p 80:80 74th/redmine-all-in-one:JP```

### include English default data

```docker run -d --name redmine --restart=unless-stopped -p 80:80 74th/redmine-all-in-one:EN```

## feature

* Redmine 3.2
* hosted subversion repository : http://dockerhost/svn/
* hosted git repository : http://dockerhost/git/
* include database
* include plugins for agile development

## included plugins

* [SCM Creator](http://www.redmine.org/plugins/redmine_scm) (GPLv2)
    * https://github.com/ZIMK/scm-creator
* [Backlogs](http://www.redminebacklogs.net/) (GPLv2)
    * https://github.com/backlogs/redmine_backlogs
* [Issue template](http://www.redmine.org/plugins/issue_templates) (GPLv2)
* [Code Review](http://www.redmine.org/plugins/redmine_code_review) (GPVv2)
* [Clipboard image paste](https://github.com/peclik/clipboard_image_paste)
* [Drafts](https://github.com/jbbarth/redmine_drafts)

## problem

* subversion is able to be created at only creating a project
* git repositories don't have authentication

## how to configure redmine

If you use need to change settings(ex, mail), you an cwrite [[config/configuration.yml.example]] and push settings by belong command.

```
docker cp ./configuration.yml redmine:/var/lib/redmine/config/configuration.yml
docker restart redmine
```

## notes

Repositories and other created files are not plased in a volume. I think  when you want to make a backup, you can use ```docker export containername > backup.tar```  and ```docker import backup.tar redmine```.

I'm not an expert on RoR and redmine. So don't have a plan to prepare a way to upgrage Redmine in a container.
