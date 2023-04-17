# dbt Monitoring

This models contained in this project do not pertain to any particulary sync, but
instead are used to monitor the overall health of our other dbt pipelines. We use the
[elementary]("https://www.elementary-data.com/") package to upload the results of our
dbt runs to our data warehouse. We then used elementary's structured data to build our
own views, dashboards, etc. to monitor the health of our pipelines.