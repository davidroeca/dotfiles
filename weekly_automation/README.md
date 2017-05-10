## Automation directory

This contains weekly automated tasks for use by cron.

In order for them to work, add the following line to crontab (`crontab -e`):

```crontab
# Check personal anacrons every hour at the 15th minute
15 * * * * /usr/sbin/anacron -t /home/david/.anacron/etc/anacrontab -S /home/david/.anacron/etc/spool
```

This runs all automatic anacrons specified in the anacrontab at the 15th minute of every hour every day.

So tasks that must be run on the pre-specified intervals will be verified every day and anacron will handle period runs if the defined time gap between tasks has been reached.
