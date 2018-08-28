## My Config

Specific configuration files for use at home and work. Most files are
configured around using [Linux Mint](https://www.linuxmint.com/), but some
configurations are likely platform-agnostic.

Depends on `stow` - `sudo apt install stow`

## Anacron directory

`make link_anacron`

This contains automated tasks at predefined intervals for use by cron/anacron.

In order for the automated tasks to run, add the following line to crontab
(`crontab -e`):

```crontab
# Check personal anacrons every hour at the 15th minute
15 * * * * /usr/sbin/anacron -t /home/david/.anacron/etc/anacrontab -S /home/david/.anacron/etc/spool
```

This runs all automatic anacrons specified in the anacrontab at the 15th minute
of every hour every day.

So tasks that must be run on the pre-specified daily intervals will be verified
every day and anacron will handle period runs if the defined time gap between
tasks has been reached.

#### Dependencies
* anacron
* cron daemon
* realpath
* dirname
* python3
* xdg-open
